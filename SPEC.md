# U3ZUB — site specification

Describes what the site **is** today. For anything not yet built, see §9.

**Last updated:** 2026-10-01
**Owner:** Stanislav Synko
**Live:** https://u3zub.com (also `www.u3zub.com`)
**Hosting:** Vercel — team `safitudos-projects`, project `website`
**Stack:** static HTML/CSS/JS. No framework, no build step, no dependencies.
**Languages:** English (default) and Ukrainian, toggled in nav and footer

---

## 1. Identity

**Name:** U3ZUB (stylized "U3zub" in lower case where appropriate). The "3" is a stylized Ukrainian trident (тризуб) — the name itself encodes the trident.

**Tagline (EN):** Ukrainian rock for the free world.
**Tagline (UA):** Український рок за вільний світ.

**Logo:** wordmark only, no separate icon. Heavy military-stencil U3ZUB with the "3" rendered as a stencil trident, in pure black. Shipping file is `website/assets/wordmark.jpg`; the original lives at `brand-explore/round-02/public/logos/50-trident-stencil-trident.jpg` (byte-identical). **Still a raster** — a vector version has never been produced.

**Visual mood:** brutalist · stencil · militarist · ancestral · defiant.

**Color system** (CSS custom properties, top of `index.html`):

| Token | Value | Use |
|---|---|---|
| `--ink` | `#000000` | primary |
| `--paper` | `#FFFFFF` | surface |
| `--yellow` | `#FFD500` | small accents only — hover states, badges, the Karolina card |
| `--blue` | `#0057B7` | two places only: the active language toggle once the nav is scrolled, and the `/rider` print-bar hover |
| `--mute` | `#666666` | subtle text |

Both flag colors stay as small UI accents. Neither is ever used as a large fill.

**Typography** (Google Fonts, loaded in `<head>`):
- **Display / headings:** Stardos Stencil 400/700 — `var(--stencil)`, uppercase
- **Body:** Manrope 400/500/700/800
- **Mono / eyebrows / metadata:** JetBrains Mono 400/700 — `var(--mono)`
- All three cover Cyrillic.

**Photography:** high-contrast, grayscale or near-grayscale. Feed thumbnails carry a grayscale filter that lifts on hover. Hero video sits under a heavy black vignette so the manifesto reads.

---

## 2. Voice

Defiant, grounded, no kitsch. Short sentences. No "join the journey" startup vocabulary.

**Manifesto (EN)** — hero copy, `index.html`:

> U3ZUB was born with the war.
> Since 2022 we have played to keep one truth alive: this is not Ukraine's war alone. It is the free world's fight against authoritarianism.
> If Ukraine wins, the order that protects all of us holds. If Ukraine falls, Europe is next, and the world that took eighty years to build comes apart.
> We play Ukrainian songs in rock arrangements — folklore, anthems of resistance, our own takes on the songs that shaped us — because culture is one of the things they came to destroy, and one of the things we will not let them.

**Manifesto (UA)** — the Ukrainian text ships alongside it in the same block. Still carries the original machine-drafted phrasing; **never reviewed by a native speaker.** Same applies to every `data-ua` string on the site.

---

## 3. Routes

| Route | File | What it is |
|---|---|---|
| `/` | `website/index.html` | long-scroll one-pager, five numbered sections |
| `/archive` | `website/archive.html` | full media wall, filter chips, 24-item batches |
| `/rider` | `website/rider.html` | tech rider, styled to print clean to letter-size PDF |

`vercel.json` sets `cleanUrls: true`, so `.html` is stripped from all three.

**Nav** (sticky; transparent over hero, solid after one viewport of scroll): logo · LIVE · ARCHIVE · PEOPLE · SUPPORT · CONTACT · EN/UA toggle. Collapses to a hamburger under 860px.

**Footer:** wordmark + tagline · Sections column · Reach (Instagram, media archive) · Language · `© <year> U3ZUB`.

---

## 4. Homepage sections

### 4.1 Hero
Full viewport. Muted autoplay looping background video (`assets/hero/hero-1.mp4`, 14 MB, poster `hero-1.jpg`) under a black vignette. Left column: wordmark, tagline, four manifesto paragraphs, and a partner line linking [House of Ukraine](https://houseofukraine.org/) and [Shield of Freedom](https://shieldoffreedom.org/). Right: a "Next show" pill — **currently hardcoded in the markup**, not driven by `UPCOMING`. Scroll cue at the bottom.

An iOS-Safari autoplay workaround re-attempts `play()` on first touch/click/scroll and on `loadedmetadata`.

### 4.2 LIVE — § 01
Two columns. Left: **Upcoming** (from `UPCOMING`) then **Past · last five** (from `PAST`, which is `EVENTS.slice(0, 5)`). Right: a "Book us" panel — copy, an Instagram DM button, and a link to the tech rider.

### 4.3 Feed — § 02 · "WHERE WE PLAYED. WHAT WE FILMED."
The centerpiece. Full-bleed black, two columns:

- **Left — where we played.** All 18 `EVENTS` that have art, grouped under year headings, newest first. Each row: poster thumbnail, name, city, month. Click opens the lightbox on that event's poster.
- **Right — what we filmed.** Six band photos followed by nine selected clips (`VIDEO_SLUGS`). Each tile is a static thumbnail with a type badge; videos carry a play glyph. Click opens the lightbox — video items get a `<video controls autoplay preload="metadata">`.

A `balance()` routine clips the taller column to match the shorter one and fades its edge, re-running on every image load and on resize. Disabled below 900px, where the columns stack.

Below the columns: an "Open full archive" bar linking to `/archive`.

### 4.4 PEOPLE — § 03
Grid of five member cards from `MEMBERS` — portrait, name, role, one-line bio, all bilingual. Below it, a wider **featured vocalist** card for Karolina with her viral stat linking to the source post. Her card renders a stencil "K" placeholder; **there is no photo of her on the site.**

### 4.5 SUPPORT — § 04 · "STAND WITH UKRAINE"
Numbered list of six funds from `CHARITIES`, each a full-row outbound link with name, description, and a Donate button. Shield of Freedom and House of Ukraine carry a `PARTNER` badge.

### 4.6 CONTACT — § 05
Centered, single column. One Instagram button. No form, and **no email address** — the `contact@u3zub.com` in earlier drafts was never set up, so every "reach us" path on the site is Instagram DM.

### 4.7 Lightbox
Shared by the feed and the event rows. Title, subtitle, media stage, ESC hint. Locks body scroll iOS-safely (fixed position + restore). Closes on ESC, backdrop click, or the × button. **Single item only — no carousel**; the thumbnail strip, item counter, and arrow-key navigation were removed in the 2026-08-22 cleanup because none of them were ever wired up.

---

## 5. `/archive`

Standalone page. Thin header strip with wordmark and a back arrow. Filter chips (`ALL · VIDEOS · PHOTOS · POSTERS`) over a masonry wall of everything: 27 clips, 6 photos, 19 posters. Loads in batches of 24 on scroll. Click opens a lightbox with full media and caption. Same footer as the homepage.

---

## 6. Behavior

- **Scroll:** native, no scroll-jacking.
- **Animations:** `.reveal` elements fade up 16px once on first intersection, then unobserve.
- **Reduced motion:** `prefers-reduced-motion` disables reveals and the scroll cue. It does **not** currently stop the hero video.
- **Mobile:** everything stacks to one column; nav becomes a hamburger; hero video stays inline and muted.
- **A11y:** black-on-white clears WCAG AA. Tiles and rows are real `<button>`s, so they are keyboard reachable. The lightbox is `role="dialog" aria-modal="true"` but **does not trap focus or restore it on close.**
- **Language:** the toggle sets `documentElement.lang` and CSS shows the matching `data-en` / `data-ua` spans. Choice persists in `localStorage` under `u3zub.lang`.

---

## 7. Data

All data is hardcoded as JS consts at the bottom of `index.html` — there is no CMS and no JSON file. To change content, edit the arrays.

| Const | Shape |
|---|---|
| `EVENTS` (21) | `{id, name_en, name_ua, date, city, poster, cover}` — newest first |
| `UPCOMING` (2) | `{date, time, venue, city, poster, url}` |
| `PAST` | derived: `EVENTS.slice(0, 5)` |
| `MEMBERS` (5) | `{name, role_en, role_ua, bio_en, bio_ua, photo}` |
| `FEATURED` | Karolina — `{name, role_*, bio_*, stat, statUrl, photo}` |
| `CHARITIES` (6) | `{name, sub, desc_en, desc_ua, url, partner?}` |

`archive.html` keeps its own separate `VIDEOS` / `PHOTOS` / `POSTERS` lists. **These are not shared with `index.html`** — adding media means editing both files.

### Roster
- **Oleksandr Dubovenko** — Frontman · Vocals · Acoustic guitar
- **Kostiantyn Dubovenko** — Electric guitar · Backing vocals
- **Stanislav Synko** — Bass guitar
- **Mark Wilson** — Drums
- **Khrystyna** — Keyboards · Backing vocals
- **Karolina** — Featured Vocalist (anthem, bilingual covers)

---

## 8. Assets

`website/assets/` — 2.2 GB on disk.

| Path | Contents |
|---|---|
| `wordmark.jpg` | the stencil logo, used in hero and footer |
| `hero/` | `hero-1.mp4` (14 MB) + poster frame |
| `clips/` | 27 encoded performance videos, **2.0 GB** · `clips/thumbs/` holds the 27 JPEG thumbnails |
| `posters/` | 20 event posters, 101 MB |
| `photos/` | 6 band photos |
| `people/portraits/` | 5 AI-generated member portraits (shipped) |
| `people/*` | raw reference photos — kept as portrait source, excluded via `.vercelignore` |
| `team/` | 2 group shots |

`brand-explore/` (outside `website/`) holds the logo exploration rounds and `encode-clips.sh`, the ffmpeg script that produced `clips/` from `~/Movies/u3zub-archive/raw`. It is not deployed.

---

## 9. Not built

Carried forward from the original spec, still open:

- **MUSIC section** — no recordings exist and no distribution is set up. Never built.
- **Press / EPK** — no EPK zip, no press quotes, no bio PDF. The tech rider at `/rider` is the only press asset. The CSS for this section was deleted in the 2026-08-22 cleanup; it would need rebuilding.
- **`contact@u3zub.com`** — never provisioned. Contact is Instagram DM only.
- **Vector logo** — the wordmark is still a JPEG. Blocks a clean favicon and a sharp OG image.
- **Favicon** — absent; the site 404s on `/favicon.ico`.
- **OG image + `MusicGroup` JSON-LD** — neither is present.
- **Karolina portrait** — placeholder "K" until a photo exists.
- **Ukrainian copy review** — every `data-ua` string is unreviewed.
- **Lightbox carousel** — events can hold both a poster and a cover, but only the first is ever shown.
- **Shared data between `index.html` and `archive.html`** — currently duplicated by hand.
- **Clip weight** — the 1.5 GB in `clips/` uploads on every `vercel deploy`. Either cut short previews or move the originals to a separate project and reference by URL.

Explicitly out of scope: merch, newsletter, blog, user accounts, comments.

---

## 10. Tech rider

`rider.html` is the source of truth and is self-contained. It carries, in order: a band
blurb with tags (5 musicians · +1 featured vocal · ~75–90 min set · festivals/rallies/concerts),
a **Quick facts** box (format, stage min. 16'×12', power 2× 20A circuits, sound check 60 min,
languages UA·EN), the equipment table below, a typical **stage plot**, and a
**hospitality / access** list. It ends with a print bar and is styled to export clean to
letter-size PDF via Cmd+P. Header is marked `Rev. 2026.04 · v1` — bump that when the rider changes.

Equipment U3zub provides:

| # | Item | Qty |
|---|------|-----|
| 1 | Wireless handheld microphone | 1 |
| 2 | Wired handheld microphones | 3 |
| 3 | Extension cords | 2 |
| 4 | Surge protectors | 2 |
| 5 | 15" loudspeakers with stands | 2 |
| 6 | 18" subwoofer speakers | 2 |
| 7 | 12-channel digital mixer | 1 |
| 8 | Boom microphone stands | 4 |
| 9 | XLR cables — sufficient for all wired mics and speakers | — |
| 10 | Power cables — sufficient for all speakers and the mixer | — |

Stage: 5 musicians plus space for one featured vocalist. Standard rock band setup.
