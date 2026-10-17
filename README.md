# Sama Buku — CV Arunika Sama Karya

Website company profile penerbit buku dengan katalog dan admin CRUD.

## Jalankan secara lokal

Persyaratan: Node.js 20 atau lebih baru.

```bash
npm install
npm run dev
```

Buka URL lokal yang ditampilkan Vite.

## Fitur yang tersedia

- Halaman Beranda, Tentang Kami, Katalog Buku, Detail Buku, Untuk Penulis, dan Kontak.
- Pencarian katalog dan filter kategori.
- Admin demo: tambah/edit/hapus buku, upload cover, draft/published, featured.
- Pengaturan brand dasar.
- Data katalog dan pengaturan disimpan di localStorage browser.
- Responsive desktop dan mobile.

## Login demo

- Username: `admin`
- Password: `samabuku123`

Akses dashboard dari ikon pengaturan di kanan bawah atau tautan Admin pada footer.

## Catatan penting untuk produksi

Versi ini merupakan MVP front-end yang dapat dijalankan dan diuji langsung. Penyimpanan memakai `localStorage`, sehingga data hanya tersimpan di browser/perangkat yang sama. Login demo tidak aman untuk produksi; jangan menggunakannya sebagai autentikasi publik.

Sebelum deploy untuk penggunaan nyata:
1. Hubungkan Supabase atau backend server untuk PostgreSQL dan penyimpanan gambar.
2. Implementasikan autentikasi admin server-side dan Supabase Auth.
3. Aktifkan Row Level Security (RLS) untuk tabel buku, pengaturan, profil admin, dan pesan kontak.
4. Simpan cover di object storage, bukan sebagai data URL di localStorage.
5. Tambahkan validasi server-side, rate limiting dan proteksi spam untuk form kontak.
6. Ganti data demo dan informasi kontak dengan data resmi Sama Buku.

Buku contoh dalam katalog adalah data ilustrasi dan harus diganti sebelum dipublikasikan.
