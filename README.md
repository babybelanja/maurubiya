# Rubiya (maurubiya.id) — Showcase

Katalog *showcase* untuk merek **Rubiya**, disajikan di `maurubiya.id`. Register
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
assets/img/               # hero mukena, logo, og-image, turunan produk
index.html                # beranda
produk/index.html         # katalog + filter kategori
tentang.md                # /tentang/
kontak.md                 # /kontak/
404.html
bin/images                # pipeline master → WebP/AVIF 640/1280/1600
AGENTS.md                 # aturan SEO + Lighthouse
```

## Komponen beranda

Hero adalah crossfade carousel berisi enam warna mukena, ditampilkan **utuh**
(`object-fit: contain`) di kolom kanan selebar 48% dengan tinggi band
`clamp(28rem, 85svh, 54rem)`. Teks duduk di kolom kiri pada latar krem, jadi
tidak perlu scrim dan tidak ada teks di atas foto.

Latar band mengikuti foto yang sedang tampil: elemen `[data-hero-backdrop]`
memakai gambar aktif sebagai backdrop blur (`filter: blur(22px)`), lalu ditutup
veil krem bergradasi sebelum kolom foto. Teks tetap tinta di atas bidang terang,
jadi kontras tidak bergantung pada warna yang kebetulan tampil — diukur 10:1
sampai 14:1 untuk navy, teracota, dan hitam. Tepi kiri kolom foto di-feather
dengan `mask-image` supaya tidak ada garis vertikal keras.

Di bawah 56rem kolom menumpuk: foto 4:5 selebar layar (tanpa crop) lalu teks di
bawahnya; backdrop dan veil disembunyikan. Hanya slide pertama yang dimuat saat halaman dibuka; slide lain
disimpan di `<template>` dan baru dipasang saat dibutuhkan. Tanpa JavaScript
hanya slide pertama yang tampil dan tombol titik disembunyikan. Perpindahan
slide menunggu gambarnya selesai di-decode, jadi band tidak pernah berkedip
kosong. Auto-advance dimatikan saat `prefers-reduced-motion: reduce`.

## Menjalankan lokal

```sh
bundle install
bundle exec jekyll serve --livereload
# buka http://127.0.0.1:4000
```

## Gambar

Google Drive hanya menjadi **sumber/referensi**, bukan host gambar. Alurnya:

1. Tarik folder Drive secara lokal (`gdown --folder <url>` atau `rclone`).
2. Upscale master 4x dengan Real-ESRGAN, lalu simpan sebagai WebP 2400 px:

   ```sh
   upscayl-bin -i sumber.jpg -o /tmp/4x.png -s 4 \
     -n upscayl-standard-4x -m /Applications/Upscayl.app/Contents/Resources/models
   magick /tmp/4x.png -auto-orient -resize "2400x3000>" -quality 88 \
     ~/Downloads/maurubiya/upscaled/nama-2400w.webp
   ```

   Foto sumber dari Drive umumnya sudah 1080×1350; tanpa langkah ini tidak ada
   bahan nyata untuk lebar 1280/1600.
3. Hasilkan turunan web dengan `bin/images`:

   ```sh
   bin/images ~/Downloads/maurubiya/upscaled/nama-2400w.webp nama
   ```

   Menghasilkan `assets/img/produk/nama-{640,1280,1600}.{webp,avif}`. Lebar
   1920 sengaja tidak dipakai: master hasil upscale tidak bisa mencapainya di
   bawah batas ~200 KB per turunan (1920 q62 pun masih 203 KB).
4. Commit hanya turunan web. Master tetap di Drive / `~/Downloads`.
5. Setel `photo:` di front matter produk ke turunan 1280, mis.
   `/assets/img/produk/nama-1280.webp`; `_includes/image.html` menurunkan
   `srcset` 640/1280/1600 dari nama itu. Foto kedua memakai `gallery:`:

   ```yaml
   photo: /assets/img/produk/nama-1-1280.webp
   gallery:
     - photo: /assets/img/produk/nama-2-1280.webp
       alt: "Deskripsi foto kedua"
   ```

Katalog saat ini hanya berisi seri mukena Zeya; seluruh foto berasal dari folder
Drive yang sama. Tidak ada produk contoh atau gambar placeholder.

> Data yang belum dikonfirmasi untuk seri mukena: bahan, ukuran, dan berat.
> Jangan diisi sebelum ada sumbernya — lihat `AGENTS.md` §3.


## Deploy

Repo: `git@github.com:babybelanja/maurubiya.git`.

Deploy otomatis belum aktif: trigger `push` di `.github/workflows/pages.yml`
sengaja dikomentari karena `maurubiya.id` belum dibeli dan Pages belum
diaktifkan. Setelah domain menunjuk ke GitHub Pages:

1. Setel Pages **Source** ke **GitHub Actions**.
2. Buka komentar `push: branches: [main]` di workflow.
3. Push ke `main` (atau jalankan workflow manual).

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
