# Agent Rules — Maurubiya

These rules are binding for every change in this repository. If a change cannot
meet them, say so before making it.

---

## 1. SEO — required on every page

- **Title:** unique per page, ≤ 60 characters, brand suffix included once.
- **Meta description:** unique per page, 120–155 characters, no keyword stuffing.
  Never reuse the site description verbatim on multiple pages.
- **Headings:** exactly one `<h1>`; no skipped levels (`h2` → `h4`).
- **Canonical:** emitted by `jekyll-seo-tag`; always points at
  `https://maurubiya.id` (the `url` in `_config.yml`). Never hard-code another
  host.
- **Language:** `<html lang="id">`.
- **Alt text:** descriptive for content images; `alt=""` for decorative ones.
  Never start with "gambar" or "foto".
- **Links:** descriptive anchor text; never "klik di sini". External links get
  `rel="noopener"`.
- **URLs:** lowercase, hyphenated, trailing slash (`permalink: pretty`). A
  published permalink must not change without a redirect.
- **Structured data:** `Organization` + `WebSite` sitewide; `BreadcrumbList` on
  nested pages; `Product` only with real data — never invent ratings, prices, or
  availability.
- **Sitemap / robots:** `sitemap.xml` lists the canonical host; `robots.txt`
  references it; `404.html` and drafts are `noindex`.
- **Social:** Open Graph + Twitter card on every page; `og:image` 1200×630.
- **Email:** never write an address directly in HTML — use
  `{% include email.html %}` or `{% include email-text.html %}`.

### New-page checklist

- [ ] Title + description set in front matter
- [ ] One `<h1>`, logical `<h2>`/`<h3>` order
- [ ] Canonical host correct (check built output)
- [ ] Alt text on every image
- [ ] Internal links use real page titles
- [ ] JSON-LD present and accurate
- [ ] Appears in `sitemap.xml`
- [ ] `noindex` only where intended

---

## 2. Lighthouse — required on every change

Targets for **mobile** Lighthouse (production build):

| Category | Target |
| --- | --- |
| Performance | ≥ 95 |
| Accessibility | 100 |
| Best Practices | 100 |
| SEO | 100 |

Core Web Vitals: **LCP ≤ 2.5s**, **CLS ≤ 0.1**, **INP ≤ 200ms**.

### Performance

- Every `<img>` needs `width` and `height` (or a CSS `aspect-ratio`) to reserve
  space.
- The LCP image is `loading="eager"` + `fetchpriority="high"` and preloaded.
  Every other image is `loading="lazy" decoding="async"`.
- Responsive images use `srcset` + `sizes` via `_includes/image.html`. Ship
  WebP/AVIF derivatives ≤ ~200 KB; never commit > 2400px masters.
- Fonts are self-hosted (one variable woff2, preloaded). Do not add a font CDN.
- No render-blocking third-party scripts. All JS is inline at the end of
  `<body>`; target < 5 KB gzipped. The page must work without JS.
- No layout shift from fonts, images, late banners, or injected content.
- No unused CSS shipped in `main.css`.

### Accessibility

- Body text contrast ≥ 4.5:1; large text ≥ 3:1. The accent `#9a5a43` is chosen to
  pass on `#f6f4ef`; if the accent changes, re-check contrast.
- Every interactive element has a visible `:focus-visible` state.
- Tap targets ≥ 44×44 px.
- Icon-only buttons have `aria-label`; toggles expose `aria-expanded`.
- Images have alt text; form inputs have labels.
- `prefers-reduced-motion: reduce` disables non-essential motion.

### Best Practices / SEO

- No console errors or 404 requests.
- HTTPS only; no mixed content.
- Crawlable links (real `<a href>`), not JS-only navigation.
- The catalog filter is progressive enhancement: all products are visible
  without JavaScript.

### Verification before merging

```sh
bundle exec jekyll build           # JEKYLL_ENV=production
bundle exec jekyll serve           # local review
npx lighthouse http://127.0.0.1:4000 --view --form-factor=mobile
```

If a target cannot be met, document the reason and the measured score in the
commit message. Do not silently lower the target.

---

## 3. Content & design

- Register: **clean catalog** (HAY-anchored). Warm off-white, one sans, hairlines,
  terracotta CTAs, near-square corners.
- Copy: benefit-led, short, Bahasa Indonesia. No superlatives, urgency, emoji, or
  unverifiable claims.
- No prices in the showcase; transactions route to WhatsApp.
- Product placeholders live in `_products/*.md` and `assets/img/produk/*.svg`;
  replace both together with real data and photography.

## 4. Housekeeping

- `Gemfile.lock` is committed.
- `opencode.json` stays local and untracked.
- Generated images live under `assets/img/`; keep the directory under 10 MB.
- Do not add a dependency without a clear need and a Lighthouse check.
