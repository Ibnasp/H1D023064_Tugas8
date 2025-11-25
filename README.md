## Screenshot Aplikasi
<img src="https://github.com/user-attachments/assets/c5f13842-069e-4991-b9cb-603c469cf77e" width="200"/>
<img src="https://github.com/user-attachments/assets/acf7322f-c350-43e5-b7f8-7ee4af741a08" width="200"/>
<img src="https://github.com/user-attachments/assets/d6751a29-6761-46ca-8b09-906d47abf307" width="200">
<img src="https://github.com/user-attachments/assets/b27b7134-7d3b-4a6b-8aa9-8553cd26a1c2" width="200">
<img src="https://github.com/user-attachments/assets/870ccddb-dfbf-4229-903c-7c0e2a5bb804" width="200">
<img src="https://github.com/user-attachments/assets/f0db467d-930f-41a7-8881-098aa5a63d90" width="200">



## Penjelasan kode "tokokita"

1. Halaman Registrasi (registrasi_page.dart)
<br>Halaman ini digunakan untuk membuat akun baru sebelum login ke aplikasi. Penjelasan fungsi utama yang ada pada registrasi_page:
    - GlobalKey<FormState>: dipakai agar form bisa melakukan validasi.
    - TextEditingController: untuk mengambil input dari TextField (nama, email, password).
    - Form(): wrapper utama untuk input dengan validasi.
    - _namaTextField(): TextField nama dengan validasi minimal 3 karakter.
    - _emailTextField(): TextField dengan validasi format email.
    - _passwordTextField(): TextField password dengan validasi minimal 6 karakter.
    - _passwordKonfirmasiTextField(): untuk cocokkan password & konfirmasi.
    - _buttonRegistrasi(): menjalankan validasi form dan nantinya mengirim request ke REST API (saat ini belum).

    Alur Halaman: User mengisi nama, email, password, konfirmasi password. Kemudian form dicek validasinya.

2. Halaman Login (login_page.dart)
<br>Halaman login digunakan untuk autentikasi ke server. Penjelasan fungsi utama yang ada pada login_page:
    - _emailTextField(): TextField dengan validasi format email dan tidak boleh kosong.
    - _passwordTextField(): TextField password dengan validasi tidak boleh kosong & disembunyikan (obscureText).
    - _buttonLogin(): mengecek validasi form, lalu melakukan proses login (saat ini belum ada).
    - _menuRegistrasi(): navigasi ke halaman registrasi.

    Alur Halaman: User memasukkan email dan password kemudian jika valid, halaman akan masuk ke menu produk.

3. Halaman List Produk (produk_page.dart)
<br>Ini adalah halaman utama setelah login. Semua produk ditampilkan dalam bentuk list. Bagian utama dalam produk_page:
    - AppBar(title: Text('List Produk (Nama)')):  bagian yang diminta menambahkan nama panggilan, menjadi: “List Produk Ibna”
    - Drawer(): ada tombol Logout.
    - ListView(): menampilkan data produk dalam bentuk list.
    - ItemProduk(): widget untuk setiap item (Card + ListTile).

    Alur Halaman: Data produk dimuat, kemudian klik icon + untuk pindah ke halaman tambah produk, dan klik pada produk untuk masuk ke halaman detail produk.

4. Halaman Form Produk (produk_form.dart)
<br>Dipakai untuk Tambah Produk dan Ubah Produk. Bagian penting pada produk_form:
<br>Variable:
    - judul yang otomatis berubah: "TAMBAH PRODUK" / "UBAH PRODUK"
    - tombolSubmit yang otomatis berubah: "SIMPAN" / "UBAH"
    - Fungsi isUpdate(): mengecek apakah form dipanggil untuk edit. Jika ya, maka field terisi data produk lama, dan judul action bar berubah.
    
    TextField:
    - _kodeProdukTextField()
    - _namaProdukTextField()
    - _hargaProdukTextField()

    Action Bar Tambahan: Pada action bar ditambahkan nama panggilan, hasilnya: "Tambah Produk Ibna", "Ubah Produk Ibna".

5. Halaman Detail Produk (produk_detail.dart)
<br>Menampilkan detail produk dan menyediakan tombol Edit & Delete. Pada produk_detail menampilkan: Kode Produk, Nama Produk dan Harga Produk

    Tombol:
    - EDIT untuk membuka ProdukForm() dengan data lama.
    - DELETE untuk menampilkan dialog konfirmasi.

    Fungsi delete:
    - confirmHapus() menampilkan dialog konfirmasi.
    - Judul ActionBar disesuaikan, hasilnya: "Detail Produk Ibna"
