# Maurubiya — Showcase

Katalog *showcase* untuk merek **Maurubiya** di `maurubiya.id`. Register
**clean catalog** (acuan HAY): latar gading hangat, satu sans, aturan garis
tipis, dan tombol terakota. Tanpa keranjang dan tanpa harga — transaksi
dialihkan ke WhatsApp.

- Dibangun dengan **Jekyll 4.4**
- Deploy: **GitHub Actions** (`.github/workflows/pages.yml`) → GitHub Pages
- Font: Plus Jakarta Sans, *self-hosted* (variable woff2)
- Aturan SEO + Lighthouse: lihat `AGENTS.md`

## Struktur

```
_config.yml               # koleksi produk, permalink, plugin, sass
_data/site.yml            # navigasi, kontak, sosial, analytics, umbrella
_data/categories.yml      # kategori produk
_products/*.md            # satu berkas per produk → /produk/<slug>/
_includes/                # head, header, footer, image, product-card, email
_layouts/default.html     # shell halaman + JS kecil (nav, filter, reveal)
_layouts/page.html        # halaman teks (Tentang)
_layouts/product.html     # detail produk + JSON-LD Product
_sass/                    # tokens, base, type, components
assets/css/main.scss      # @use seluruh partial
assets/fonts/             # Plus Jakarta Sans (woff2)
assets/img/               # hero, logo, og-image, placeholder produk
index.html                # beranda
produk/index.html         # katalog + filter kategori
tentang.md                # /tentang/
kontak.md                 # /kontak/
404.html
bin/images                # pipeline master → WebP/AVIF 3 lebar
bin/make-placeholders.sh  # regenerate placeholder SVG
AGENTS.md                 # aturan SEO + Lighthouse
```

## Menjalankan lokal

```sh
bundle install
bundle exec jekyll serve --livereload
# buka http://127.0.0.1:4000
```

## Gambar

Google Drive hanya menjadi **sumber/referensi**, bukan host gambar. Alurnya:

1. Tarik folder Drive secara lokal (`gdown --folder <url>` atau `rclone`).
2. Hasilkan turunan web dengan `bin/images`:

   ```sh
   bin/images ~/Downloads/maurubiya/nara.jpg nara
   ```

   Menghasilkan `assets/img/produk/nara-{640,1280,1920}.{webp,avif}`.
3. Commit hanya turunan web. Master tetap di Drive.
4. Ganti `image:` di front matter produk (mis. `/assets/img/produk/nara-1280.webp`).
   `_includes/image.html` otomatis membuat `<picture>` + `srcset`.

Saat ini semua produk memakai placeholder SVG (`bin/make-placeholders.sh`).

## Deploy

Push ke `main` memicu build `JEKYLL_ENV=production` lalu menerbitkan ke GitHub
Pages. Setel Pages **Source** ke **GitHub Actions**.

## Verifikasi Lighthouse

Build produksi, Chrome headless, 20 November 2026:

| Halaman | Performance | Accessibility | Best Practices | SEO |
| --- | --- | --- | --- | --- |
| Beranda | 100 | 100 | 100 | 100 |
| Katalog | 100 | 100 | 100 | 100 |
| Detail produk | 100 | 100 | 100 | 100 |
| Tentang / Kontak | 100 | 100 | 100 | 100 |
| 404 | 100 | 100 | 100 | 66* |

\* 404 sengaja `noindex`, sehingga audit "page is crawlable" gagal.
Metrik mobile: LCP 0,8 dtk · CLS 0 · TBT 0 ms.

## Catatan

- `opencode.json` bersifat lokal dan tidak diikutkan (`.gitignore`).
- **Email jangan ditulis langsung di HTML.** Pakai `{% include email.html %}`
  atau `{% include email-text.html %}`.
- `whatsapp` dan `umbrella` di `_data/site.yml` masih placeholder/kosong —
  isi sebelum publikasi.
- `Gemfile.lock` di-commit agar build Actions reprodusibel.
