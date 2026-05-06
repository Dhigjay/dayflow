# Product Requirements Document (PRD) - DayFlow

**Versi:** 1.0  
**Status:** In-Progress  
**Pemilik Produk:** [Dhigjay]  
**Desainer/Developer:** Jay.dev  

---

## 1. Ringkasan Eksekutif
**DayFlow** adalah aplikasi manajemen tugas (to-do list) berbasis mobile yang dirancang untuk membantu pengguna mengelola jadwal harian dengan antarmuka yang berani, dinamis, dan tidak kaku. Menggunakan gaya desain **Neo-brutalism**, DayFlow memadukan fungsionalitas produktivitas dengan estetika modern.

## 2. Tujuan & Visi
* **Tujuan:** Menyediakan platform manajemen jadwal yang intuitif dengan pelacakan statistik yang nyata. Serta membuat pribadi yang lebih produktif.
* **Visi:** Mengubah manajemen waktu dari aktivitas yang membosankan menjadi pengalaman visual yang menarik melalui desain yang unik.

## 3. Target Pengguna
1.  **Pelajar/Mahasiswa:** Membutuhkan pengaturan jadwal belajar yang rapi.
2.  **Profesional Muda:** Mengelola tugas pekerjaan dan personal dalam satu tempat.
3.  **Penggemar Estetika:** Pengguna yang bosan dengan desain aplikasi produktivitas yang terlalu formal atau minimalis standar.

## 4. Fitur Utama (User Features)

### 4.1 Manajemen Jadwal (Schedule Management)
* **Tambah Tugas:** Input judul/jadwal, tanggal, waktu, kategori, prioritas, dan catatan tambahan.
* **Prioritas Tugas:** * *High:* Ungu Tua (#7B1FA2)
    * *Medium:* Ungu Muda (#CE93D8)
    * *Low:* Putih (Border Hitam)
* **Kategori:** Work, Personal, Health, Study, Other.
* **Konfirmasi Selesai:** Dialog konfirmasi sebelum menandai tugas sebagai selesai atau mengembalikannya ke daftar pending.

### 4.2 Dashboard & Statistik (Home Page)
* **Sinkronisasi Data:** Menampilkan profil pengguna (Username & Email) secara dinamis dari proses registrasi/login.
* **Statistik Tugas:**
    * *Pending:* Jumlah tugas yang belum selesai.
    * *Completed:* Jumlah total tugas yang berhasil diselesaikan.
    * *Streak:* Pelacakan konsistensi penyelesaian tugas (saat ini disamakan dengan jumlah completed).

### 4.3 Sidebar & Navigasi
* **Sidebar Dinamis:** Akses cepat ke profil dan statistik.
* **Logout:** Tombol keluar dengan dialog konfirmasi keamanan.

### 4.4 Kustomisasi Profil (Rencana Pengembangan)
* **Ubah Foto Profil:** Integrasi dengan `image_picker` untuk mengambil foto dari galeri atau kamera.
* **Update Informasi:** Kemampuan mengubah username atau email di halaman profil.

## 5. Spesifikasi Teknis & Desain
* **Framework:** Flutter (Dart).
* **State Management:** AppState (Custom Local State).
* **Gaya Desain:** Neo-brutalism (Bold borders, solid shadows, 0 blur radius).
* **Tipografi:** Space Grotesk / Poppins (Non-formal, modern).
* **Package Utama:** `google_fonts`, `image_picker` (rencana).

## 6. Alur Pengguna (User Flow)
1.  **Start/Auth:** User login/register -> Data disimpan ke state.
2.  **Home:** User melihat jadwal -> Tambah tugas baru.
3.  **Action:** User menyelesaikan tugas -> Konfirmasi muncul -> Statistik (Pending & Completed) diperbarui secara real-time.
4.  **Profile/Sidebar:** User melihat performa tugas dan melakukan logout atau kustomisasi profil.

## 7. Metrik Keberhasilan
* Peningkatan jumlah tugas yang diselesaikan (Task Completion Rate).
* Retensi pengguna harian melalui fitur pelacakan *Streak*.
* Kepuasan visual pengguna terhadap kustomisasi profil.