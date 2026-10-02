#!/bin/bash
# Encode all .mov/.mp4 in ~/Movies/u3zub-archive/raw to web-optimized H.264.
# Preserves native aspect ratio (no pillarbox padding).
# Output: media/clips/{stem}.mp4 (deployed as the u3zub-media Vercel project)
#         thumbs → website/assets/clips/thumbs/{stem}.jpg
set -e
SRC="${SRC:-$HOME/Movies/u3zub-archive/raw}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="${OUT:-$ROOT/media/clips}"
THUMBS="${THUMBS:-$ROOT/website/assets/clips/thumbs}"
mkdir -p "$OUT" "$THUMBS"

shopt -s nullglob nocaseglob
COUNT=0; OK=0; FAIL=0
for f in "$SRC"/*.{mov,mp4}; do
  [ -f "$f" ] || continue
  COUNT=$((COUNT+1))
  base=$(basename "$f")
  stem="${base%.*}"
  slug=$(echo "$stem" | tr ' ' '_' | tr -cd 'A-Za-z0-9_.-' | tr '[:upper:]' '[:lower:]')
  dst="$OUT/$slug.mp4"
  echo "[$COUNT] encoding: $base → $slug.mp4"
  # Scale so the longer side is 1280, preserve aspect, even dimensions
  if ffmpeg -y -i "$f" \
      -vf "scale='if(gt(iw,ih),1280,-2)':'if(gt(iw,ih),-2,1280)':flags=lanczos" \
      -c:v libx264 -preset medium -crf 24 -pix_fmt yuv420p \
      -c:a aac -b:a 128k -ac 2 \
      -movflags +faststart \
      "$dst" -loglevel error -stats 2>&1 | tail -2; then
    sz=$(du -h "$dst" | cut -f1)
    dim=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=p=0 "$dst")
    echo "  ✓ $slug.mp4 ($sz, $dim)"
    OK=$((OK+1))
  else
    echo "  ✗ failed: $slug"
    FAIL=$((FAIL+1))
  fi
done
echo ""
echo "Done: $OK ok, $FAIL failed, $COUNT total"
du -sh "$OUT"

# Regenerate thumbs at native aspect
echo ""
echo "Regenerating thumbs..."
for f in "$OUT"/*.mp4; do
  base=$(basename "$f" .mp4)
  thumb="$THUMBS/$base.jpg"
  ffmpeg -y -ss 2 -i "$f" -frames:v 1 -vf "scale='if(gt(iw,ih),640,-2)':'if(gt(iw,ih),-2,640)'" "$thumb" -loglevel error 2>&1 | tail -1
done
echo "Thumbs regenerated."
echo ""
echo "Next: cd $ROOT/media && vercel deploy --prod   # publish clips"
