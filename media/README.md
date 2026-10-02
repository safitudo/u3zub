# U3ZUB — media bucket

Static Vercel project (`u3zub-media`) that serves only the encoded performance clips.
Kept apart from the website so site deploys do not re-upload 2 GB of video.

```
clips/   encoded H.264 clips (output of ../brand-explore/encode-clips.sh)
```

Deploy when clips change:

```sh
cd media && vercel deploy --prod
```

The website references clips by absolute URL (`CLIPS_BASE` in `website/index.html`
and `website/archive.html`). Thumbnails stay in the website under `assets/clips/thumbs/`.
