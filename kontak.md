---
layout: default
title: Kontak
description: "Hubungi Rubiya melalui WhatsApp atau surel untuk pertanyaan tentang ukuran, warna, bahan, dan ketersediaan produk. Kami membantu memilih."
---

<section class="page">
  <div class="wrap">
    <header class="page-head">
      <p class="label">Kontak</p>
      <h1>Kontak</h1>
      <p class="lead">Mari berbincang.</p>
    </header>

    <div class="contact-cards">
      {%- assign wa = site.data.site.contact.whatsapp %}
      {%- if wa and wa != "" %}
      <a class="contact-card" href="https://wa.me/{{ wa }}" target="_blank" rel="noopener">
        <span class="label">WhatsApp</span>
        <span class="contact-card__value">Chat dengan kami</span>
        <span class="contact-card__sub">Balasan pada jam kerja, 09.00–17.00 WIB.</span>
      </a>
      {%- endif %}

      <div class="contact-card">
        <span class="label">Surel</span>
        <span class="contact-card__value">{% include email.html %}</span>
        <span class="contact-card__sub">Untuk pertanyaan yang lebih panjang.</span>
      </div>

      <div class="contact-card">
        <span class="label">Lokasi</span>
        <span class="contact-card__value">{{ site.data.site.contact.city }}</span>
        <span class="contact-card__sub">Pengiriman dari Bandung ke seluruh Indonesia.</span>
      </div>
    </div>

    <div class="prose">
      <h2>Sebelum menghubungi</h2>
      <p>Sebutkan nama produk, warna, dan ukuran yang sedang dipertimbangkan. Kami akan membantu mencocokkan dengan ukuran yang biasa Anda pakai.</p>
    </div>
  </div>
</section>
