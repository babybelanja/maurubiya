#!/usr/bin/env bash
# Generate placeholder SVGs (4:5 product cards, 4:3 hero).
# Replace with real photography in assets/img/produk/ when available.
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p assets/img/produk

card() {
  local slug="$1" bg="$2" shape="$3" ink="$4" label="$5"
  cat > "assets/img/produk/$slug.svg" <<SVG
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 1250" role="img">
  <rect width="1000" height="1250" fill="$bg"/>
  <path d="M500 260c90 0 160 60 160 150v430c0 60-50 110-110 110H450c-60 0-110-50-110-110V410c0-90 70-150 160-150z" fill="$shape" opacity="0.78"/>
  <rect x="330" y="390" width="340" height="500" rx="40" fill="none" stroke="$shape" stroke-width="8" opacity="0.9"/>
  <text x="80" y="1150" font-family="system-ui, sans-serif" font-size="34" letter-spacing="8" fill="$ink" opacity="0.75">$label</text>
</svg>
SVG
}

card nara "#e6ddcc" "#cbbfa8" "#5b5245" "NARA"
card luma "#d9d3c6" "#bdb4a3" "#5b5245" "LUMA"
card sena "#c98a72" "#a96b55" "#f6f4ef" "SENA"
card aria "#9aa192" "#7f8a76" "#2f342c" "ARIA"
card bima "#d6d2cb" "#bcb7ad" "#4b4841" "BIMA"
card tara "#c7b9a6" "#ac9c86" "#4f463b" "TARA"

cat > assets/img/hero.svg <<'SVG'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1600 1200" role="img">
  <rect width="1600" height="1200" fill="#efeae1"/>
  <rect x="0" y="720" width="1600" height="480" fill="#e7e1d6"/>
  <rect x="180" y="170" width="560" height="760" fill="#c98a72"/>
  <rect x="700" y="300" width="420" height="630" fill="#d8cbb6"/>
  <rect x="1080" y="220" width="340" height="710" fill="#9aa192"/>
  <circle cx="460" cy="550" r="120" fill="#a96b55" opacity="0.6"/>
  <circle cx="910" cy="620" r="90" fill="#c6bdac" opacity="0.7"/>
</svg>
SVG

printf 'Generated placeholders in assets/img/\n'
