# U3ZUB — website

Static site. No framework, no build step, no dependencies. Plain HTML/CSS/JS.

Live at **https://u3zub.com**. Full content and behavior spec: [`../SPEC.md`](../SPEC.md).

## Local preview

```sh
cd website
python3 -m http.server 8080
# open http://localhost:8080
```

## Deploy

```sh
cd website
vercel deploy         # preview
vercel deploy --prod  # production (u3zub.com)
```

Vercel project: `website`, team `safitudos-projects`.

> **Heads up:** `assets/clips/` is 1.5 GB and is not ignored, so every deploy re-uploads it.
> Expect a slow push. See §9 of the spec for the fix.

## Structure

```
index.html     homepage one-pager — hero, live, feed, people, support, contact
archive.html   /archive — filterable media wall, 24 items per scroll batch
rider.html     /rider — tech rider, prints clean to letter-size PDF
assets/        wordmark, hero video, clips + thumbs, posters, photos, portraits
vercel.json    cleanUrls + immutable cache headers on static assets
.vercelignore  raw portrait sources and this README
```

All three pages are self-contained — CSS in a `<style>` block, JS in a `<script>` block
at the bottom, no shared files.

## Editing content

Content is hardcoded as JS consts at the bottom of `index.html`: `EVENTS`, `UPCOMING`,
`MEMBERS`, `FEATURED`, `CHARITIES`. Edit the arrays.

`archive.html` keeps its **own** `VIDEOS` / `PHOTOS` / `POSTERS` lists. New media has to be
added in both files.

Two things are hardcoded in markup rather than data, and need editing by hand:
- the hero "Next show" pill (`.hero__nextshow`) — it does not read `UPCOMING`
- `PAST` is derived as `EVENTS.slice(0, 5)`, so reordering `EVENTS` changes the LIVE section

## Adding clips

`../brand-explore/encode-clips.sh` encodes `~/Movies/u3zub-archive/raw` to web H.264
(longest side 1280, CRF 24, faststart) and regenerates `assets/clips/thumbs/`.
Note that it encodes full-length performances — that is where the 1.5 GB comes from.
