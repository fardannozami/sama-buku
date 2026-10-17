-- Tabel buku
create table if not exists public.books (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  author text not null,
  category text default 'Fiksi',
  description text default '',
  synopsis text default '',
  isbn text default '',
  year text default '2026',
  pages text default '',
  price text default '',
  cover text default '',
  status text default 'Draft' check (status in ('Published','Draft')),
  featured boolean default false,
  created_at timestamptz default now()
);

-- Tabel pengaturan (satu baris)
create table if not exists public.company_settings (
  id boolean primary key default true,
  brand text default 'Sama Buku',
  legal text default 'CV Arunika Sama Karya',
  tagline text default 'Setiap Buku, Membuka Cerita.',
  email text,
  instagram text,
  whatsapp text,
  constraint single_row check (id = true)
);

insert into public.company_settings (id) values (true) on conflict (id) do nothing;

-- RLS
alter table public.books enable row level security;
alter table public.company_settings enable row level security;

-- Public read
create policy "books_public_read" on public.books for select using (true);
create policy "settings_public_read" on public.company_settings for select using (true);

-- Authenticated (admin) write
create policy "books_auth_write" on public.books for all
  using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');
create policy "settings_auth_write" on public.company_settings for all
  using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');

-- Storage bucket untuk cover
insert into storage.buckets (id, name, public) values ('covers','covers',true)
  on conflict (id) do nothing;

create policy "covers_public_read" on storage.objects for select
  using (bucket_id = 'covers');
create policy "covers_auth_write" on storage.objects for insert
  with check (bucket_id = 'covers' and auth.role() = 'authenticated');
create policy "covers_auth_update" on storage.objects for update
  using (bucket_id = 'covers' and auth.role() = 'authenticated');
create policy "covers_auth_delete" on storage.objects for delete
  using (bucket_id = 'covers' and auth.role() = 'authenticated');

-- Seed data (buku contoh)
insert into public.books (title,author,category,description,synopsis,isbn,year,pages,price,status,featured) values
('Ruang untuk Bertumbuh','Nara Pradipta','Pengembangan Diri','Belajar menerima proses dan memberi ruang bagi diri sendiri.','Sebuah catatan hangat tentang perjalanan mengenal diri, berdamai dengan perubahan, dan tumbuh tanpa harus terburu-buru.','978-623-000-001-1','2026','184','89000','Published',true),
('Kota yang Menyimpan Hujan','Adelia Senja','Fiksi','Cerita tentang rumah, kehilangan, dan hal-hal yang kembali.','Di sebuah kota kecil yang selalu basah setelah senja, seorang perempuan menemukan kembali cerita yang lama ia tinggalkan.','978-623-000-002-8','2026','236','98000','Published',true),
('Membaca Dunia','Raka Mahendra','Pendidikan','Membuka jendela pengetahuan melalui kebiasaan membaca.','Buku pengantar untuk membangun kebiasaan membaca yang menyenangkan dan memahami dunia dari sudut pandang yang lebih luas.','978-623-000-003-5','2025','152','75000','Published',true),
('Catatan Kecil tentang Pulang','Mira Larasati','Sastra','Fragmen puisi dan prosa tentang tempat untuk kembali.','Kumpulan prosa pendek dan puisi yang merayakan kenangan, keluarga, dan perjalanan pulang dalam arti yang paling personal.','978-623-000-004-2','2025','128','68000','Published',false),
('Kerja dengan Makna','Bima Wiratama','Nonfiksi','Menata ulang hubungan kita dengan pekerjaan dan hidup.','Refleksi praktis tentang nilai, fokus, dan membangun kehidupan profesional yang selaras dengan hal-hal yang kita anggap penting.','978-623-000-005-9','2026','202','92000','Published',false),
('Atlas Imajinasi','Tim Sama Buku','Anak','Draf buku ilustrasi untuk mengajak anak bertanya dan membayangkan.','Contoh naskah yang masih dalam proses penyuntingan.','','2026','','','Draft',false);