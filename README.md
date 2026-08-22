# U3ZUB

Website for **U3ZUB** — a Ukrainian rock band based in San Diego, playing Ukrainian
folklore and anthems of resistance in rock arrangements since 2022.

The name is the band's own: the "3" is a stylized тризуб, the Ukrainian trident.

**Live:** [u3zub.com](https://u3zub.com) · **Instagram:** [@u3zubmusic](https://instagram.com/u3zubmusic)

---

## What's here

```
website/          the site — static HTML/CSS/JS, no framework, no build step
  index.html      one-pager: hero, live, feed, people, support, contact
  archive.html    /archive — filterable media wall
  rider.html      /rider — tech rider, prints to letter-size PDF
SPEC.md           full content + behavior spec, and what is still unbuilt
brand-explore/    round-01 logo concepts, and the ffmpeg clip encoder
```

Start with [`SPEC.md`](SPEC.md) for how the site is put together, or
[`website/README.md`](website/README.md) to run and deploy it.

## Run it

```sh
cd website && python3 -m http.server 8080
```

## A note on media

Most of the band's media is **not** in this repo. The video archive alone is 1.5 GB
and two clips exceed GitHub's 100 MB per-file limit. Those files live on disk and are
uploaded directly by `vercel deploy`; [`.gitignore`](.gitignore) records where each
set comes from.

What is tracked: clip thumbnails, band photos, member portraits, and the wordmark —
about 7 MB. A fresh clone runs and looks right; it is just missing the video, the
event posters, and the hero background loop.

## Support Ukraine

The site links six funds we trust. If the music moves you, move them too:
[Come Back Alive](https://savelife.in.ua/en/) ·
[United24](https://u24.gov.ua/) ·
[Prytula Foundation](https://prytulafoundation.org/en) ·
[Razom for Ukraine](https://www.razomforukraine.org/) ·
[Shield of Freedom](https://shieldoffreedom.org/) ·
[House of Ukraine](https://houseofukraine.org/)
