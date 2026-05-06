# Product Requirements Document (PRD) - DayFlow

**Nama Aplikasi:** DayFlow  
**Platform:** Mobile (Android & iOS - Flutter)  
**Pengembang:** Jay.dev  
**Versi Dokumen:** 1.1  
**Status Produk:** Dalam Pengembangan (*In-Development*)  

---

## 1. Tujuan Aplikasi
**DayFlow** dibangun dengan tujuan untuk meredefinisi cara pengguna mengelola jadwal harian mereka. Alih-alih menggunakan pendekatan minimalis yang kaku dan membosankan, aplikasi ini bertujuan untuk:
* Meningkatkan produktivitas pengguna melalui sistem pelacakan tugas yang transparan dan *rewarding* (berbasis statistik).
* Memberikan pengalaman visual yang unik, berani, dan modern melalui gaya desain *Neo-brutalism*.
* Menyediakan navigasi yang cepat dan tidak membingungkan, di mana pengguna dapat langsung melihat status keseharian mereka dalam satu kali tatap.

## 2. Perilaku Aplikasi (App Behavior)
Perilaku antarmuka dan interaksi pengguna dalam DayFlow diatur oleh prinsip-prinsip berikut:
* **Responsif & Real-time:** Setiap interaksi pengguna (seperti menyelesaikan tugas) harus secara instan memperbarui *state* aplikasi secara keseluruhan (mengurangi tugas "Pending" dan menambah tugas "Completed" serta "Streak" di Home dan Sidebar).
* **Anti-Kesalahan (Error Prevention):** Aplikasi berperilaku sangat hati-hati terhadap aksi destruktif atau perubahan status. Pengguna harus disuguhkan *Dialog Konfirmasi* sebelum melakukan "Logout", menandai tugas "Selesai", atau mengembalikan tugas selesai menjadi "Pending".
* **Gaya Visual Konsisten:** Perilaku visual secara tegas mengikuti pakem *Neo-brutalism*. Bayangan (*shadow*) bernilai *blur* 0 dengan garis batas hitam pekat. Tipografi menggunakan font modern (seperti Space Grotesk/Poppins) untuk menghindari kesan formal.

---

## 3. Penjelasan Mendalam Fitur dan Fungsi

### 3.1. Sistem Autentikasi (Start, Register, Login)
**Fungsi:** Mengidentifikasi dan menyimpan data individu pengguna agar pengalaman menjadi personal.
* **Start Page:** Halaman penyambutan dengan tipografi besar dan desain *bold* yang mengarahkan pengguna ke Login atau Register.
* **Register & Login Page:** Formulir input untuk kredensial (Username, Email, Password). 
* **Perilaku Spesifik:** Data (Username dan Email) yang berhasil diinput saat proses registrasi/login **harus** tersimpan di dalam *state* dan disinkronkan ke seluruh aplikasi (terutama Sidebar dan Profile Page).

### 3.2. Manajemen Jadwal & Tugas (Schedule & Tasks)
**Fungsi:** Modul utama tempat pengguna membuat, mengedit, melihat, dan menyelesaikan jadwal harian.
* **Pembuatan Tugas (Add Task):** Pengguna dapat memasukkan parameter tugas:
    * *Judul Tugas*
    * *Tanggal & Waktu*
    * *Kategori* (Work, Personal, Health, Study, dll.) beserta representasi ikonnya.
    * *Prioritas*
* **Indikator Prioritas Visual:**
    * **High (Tinggi):** Kartu tugas direpresentasikan dengan warna ungu tua (#7B1FA2).
    * **Medium (Sedang):** Kartu tugas direpresentasikan dengan warna ungu muda (#CE93D8).
    * **Low (Rendah):** Kartu tugas direpresentasikan dengan warna putih bergaris batas hitam.
* **Perubahan Status (Checkbox):**
    * Saat pengguna mencentang tugas di daftar "Schedule", *dialog konfirmasi penyelesaian* akan muncul. Jika disetujui, tugas berpindah ke daftar "Completed".
    * Saat pengguna menghilangkan centang di daftar "Completed", *dialog konfirmasi pembatalan* muncul. Jika disetujui, tugas kembali ke "Schedule".

### 3.3. Dashboard & Statistik Kinerja (Home Page & Sidebar)
**Fungsi:** Memberikan ringkasan performa produktivitas pengguna saat ini.
* **Task Stats (Statistik Tugas):**
    * **Pending:** Fungsi ini menghitung secara otomatis total tugas yang ada di daftar jadwal (*Schedule*) dan belum diselesaikan.
    * **Completed:** Menghitung total tugas yang berhasil diselesaikan (*Completed*).
    * **Streak:** Fungsi gamifikasi yang melacak rekor penyelesaian. (Catatan versi 1.0: Angka Streak disinkronkan agar sama dengan total tugas Completed).
* **Sidebar Dinamis:** Laci navigasi samping yang menarik data Username, Email, dan ketiga Statistik (Pending, Completed, Streak) secara *real-time* dari *AppState*, sehingga nilainya pasti sama dengan yang ada di Profile Page.

### 3.4. Personalisasi & Sesi (Profile & Logout)
**Fungsi:** Memberikan pengguna kontrol penuh atas akun dan profil mereka.
* **Kustomisasi Avatar (Profile Page):** Pengguna diberikan kebebasan untuk mengubah foto profil (*default: icon person*). Fungsi ini menggunakan akses galeri atau kamera perangkat untuk mengambil foto dan memperbaruinya di seluruh aplikasi.
* **Logout (Sidebar):** Tombol aksi untuk mengakhiri sesi.
    * *Perilaku:* Menampilkan *Dialog Konfirmasi Logout*. Jika "Ya", sistem menghapus kredensial sesi saat ini dari *state* dan melempar pengguna kembali ke Login Page, sekaligus menghapus riwayat halaman (*routing*).

---

## 4. Kebutuhan Teknis (Technical Requirements)
* **Basis Kode:** Dart / Flutter SDK.
* **Manajemen State:** Menggunakan *local state management* kustom yang dinamakan `AppState` untuk menyebarkan perubahan data profil dan statistik tugas ke `HomePage`, `AppSidebar`, dan `ProfilePage`.
* **Dependensi / Package Tambahan:**
    * `google_fonts`: Untuk memuat font kustom tanpa mengunduh file `.ttf` secara manual.
    * `image_picker`: Untuk fungsi pengambilan foto profil dari galeri/kamera.
* **Penyimpanan:** Kredensial akun dan array data tugas (`pendingTasks`, `completedTasks`) disimpan di dalam memori/penyimpanan perangkat untuk memastikan akses yang cepat.