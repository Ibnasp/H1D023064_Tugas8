## Tokokita - Aplikasi CRUD Produk + Login (Flutter + CodeIgniter 4 API)

Project ini merupakan implementasi dari Pertemuan 10 & 11 (CRUD 1 & CRUD 2) sekaligus Tugas 8 dan Tugas 9.
Aplikasi ini (Tokokita) terdiri dari:
- REST API (CodeIgniter 4)
- Fitur Login + Registrasi
- CRUD Produk (Create, Read, Update, Delete)

### Penjelasan kode "tokokita"
1. Proses Registrasi
   <br>a. Screenshot form dan isi form
   <br><img src="https://github.com/user-attachments/assets/09ffc0f1-3d6e-41bb-ad47-f4040db2011a" height="300">
   <img src="https://github.com/user-attachments/assets/f4ee3b1d-1f26-4690-97b4-4178a6996b4a" height="300">

   pada halaman ini user menginputkan nama, email, password dan konfirmasi password, kemudian ketika tombol Registrasi ditekan flutter mengirimkan data: nama, email dan password ke endpoint /registrasi.

   b. SS Popup Berhasil
   <br><img src="https://github.com/user-attachments/assets/2c38a3dd-8645-43c8-9a64-fb0997edf3b2" height="350">
   <br>kode registrasi (registrasi_page.dart):
   ```
   void _submit() {
   _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    RegistrasiBloc.registrasi(
      nama: _namaTextboxController.text,
      email: _emailTextboxController.text,
      password: _passwordTextboxController.text)
      .then((value) {
        showDialog(
          context: context,
          barrierDismissible: false, 
          builder: (BuildContext context) => SuccessDialog(
              description: 'Registrasi berhasil, silahkan login',
              okClick: () {
                Navigator.pop(context);
                },
          ));
   }, onError: (error) {
        showDialog(
          context: context, 
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
              description: 'Registrasi gagal, silahkan coba lagi',
        ));
      });
      setState(() {
        _isLoading = false;
      });
   }
   ```

   Penjelasan:
   - _formKey.currentState!.save() untuk menyimpan value dari form
   - Mengambil data dari TextField nama, email dan password. Lalu dikirim ke REST API (CodeIgniter) melalui fungsi POST /registrasi
   - Jika registrasi berhasil (response sukses), then() berjalan ketika API mengembalikan status sukses dan menampilkan popup SuccessDialog.
   - onError: (error) {showDialog(context: context,barrierDismissible: false, builder: (context) => const WarningDialog(description: 'Registrasi gagal, silahkan coba lagi')); artinya jika terjadi error (registrasi gagal) flutter akan menampilkan popup WarningDialog.

2. Proses Login
   <br>a. Screenshot form dan isi form
   <br><img src="https://github.com/user-attachments/assets/7055f8da-f46b-46fc-bed1-80ffb37b5c3e" height="300">
   <img src="https://github.com/user-attachments/assets/6079b627-c16f-4f89-a900-9be3a109f505" height="300">

   pada halaman ini user menginputkan username dan password, kemudian ketika tombol Login ditekan dan berhasil maka akan memunculkan popup login berhasil, jika gagal akan memunculkan popup login gagal. jika berhasil selanjutnya akan muncul halaman list produk.
   
   b. SS Popup Berhasil/Tidak
   <br><img src="https://github.com/user-attachments/assets/961d9830-09bb-476a-82e7-efa109a426d1" height="300">
   <img src="https://github.com/user-attachments/assets/89d78717-b5bd-47cd-ba0e-064a737a57c6" height="300">

   pada gambar 1 itu menunjukan login berhasil, kemudian gambar 2 menunjukkan login gagal. Login gagal bisa disebabkan karena akun belum terdaftar(registrasi) atau email/passwordnya tidak sesuai atau bisa juga karena tidak ada internet, API down dan URL salah.

   Kode Proses Login (login_page.dart):
   <br>Flutter mengambil email & password dari TextField, kemudian mengirim POST request ke API CodeIgniter dan menunggu respons code == 200
   - Mengirim request<br><img width="300" alt="image" src="https://github.com/user-attachments/assets/76222b8a-020f-4e75-ac32-358231d73eb5" />
   <br>Penjelasan:
        - LoginBloc.login() adalah fungsi yang bertugas mengirim POST request ke API CodeIgniter.
        - _emailTextboxController.text, mengambil isi dari field email.
        - _passwordTextboxController.text, mengambil isi password dari field password.
   - Jika berhasil (value.code == 200)<br><img width="300" alt="image" src="https://github.com/user-attachments/assets/81bf8aea-d16d-4915-b130-ee8a606cf358" />
   <br>Penjelasan:
        - API membalas dengan code = 200 artinya login sukses.
        - ketika sukses aplikasi akan menampilkan popup SuccessDialog berisi pesan “Login berhasil”.
        - barrierDismissible: false berarti popup tidak bisa ditutup dengan klik area luar maka harus menekan tombol OK.
        - Setelah login berhasil, API mengirimkan: JWT Token (untuk autentikasi), ID user dan disimpan ke SharedPreferences melalui class UserInfo. Fungsinya agar aplikasi tetap login meskipun aplikasi ditutup, dan token digunakan untuk memanggil API lain (misal tambah produk).
        - pushReplacement artinya mengganti halaman login ke halaman Produk.
   - Jika gagal<br><img width="300" alt="image" src="https://github.com/user-attachments/assets/6193ded5-42cd-4458-b518-f349c63ff0f7" />
   <br>Penjelasan:
        Jika API mengembalikan kode selain 200, misal: 400 (Password salah), 404 (Email tidak ditemukan), 500 (Server error). Maka aplikasi tidak menyimpan token, tidak berpindah halaman  dan menampilkan popup WarningDialog dengan pesan error.

**Proses CRUD Produk**<br>

3. Read / Menampilkan Daftar Produk
   <br>a. Screenshot halaman list produk
    <br><img src="https://github.com/user-attachments/assets/b3d10177-f48d-41cb-b199-7f5c013c077c" height="300">

   Pada halaman ini terdapat list produk yang telah ditambahkan, kemudian jika produk di klik akan mengarahkan ke halaman detail produk. Lalu bisa tambah produk juga dengan klik tanda + yang ada di pojok kanan atas, kemudian isi form pada halaman tambah produk.

   b. Kode list produk
   ```
       static Future<List<Produk>>getProduks() async {
            String apiUrl = ApiUrl.listProduk;
            var response = await Api().get(apiUrl);
            var jsonObj = json.decode(response.body);
            List<dynamic>  listProduk = (jsonObj as Map<String, dynamic>)['data'];
            List<Produk> produks = [];
            for (int i = 0; i < listProduk.length; i++) {
              produks.add(Produk.fromJson(listProduk[i]));
            }
            return produks;
          }
   ```
    Penjelasan:
   - Flutter melakukan GET request → /produk
   - API mengembalikan JSON list produk
   - kemudian ditampilkan dalam ListView.builder agar Flutter dapat menampilkannya dalam ListView.
   - return list produk
    
     
5. Tambah Produk<br>
    a. Screenshot form dan isi form<br>
    <img src="https://github.com/user-attachments/assets/70bf8016-80c1-4bb6-99b7-d1f87df7570a" height="300">
    <img src="https://github.com/user-attachments/assets/d2a4162b-d4cf-4bff-8d35-0dd897c87868" height="300">
    <img src="https://github.com/user-attachments/assets/ec97bccc-40b7-45bc-b078-3889dea299b9" height="300">
    <br>Pada halaman ini user mengisi form dengan kode produk, nama produk dan harga. kemudian klik tombol simpan lalu kembali ke halaman daftar produk dan data produk akan bertambah.

     b. Kode tambah produk<br>
     ```
     produk_page.dart:
     simpan(){
        setState(() {
          _isLoading = true;
        });
        Produk createProduk = Produk(id: null);
          createProduk.kodeProduk = _kodeProdukTextboxController.text;
          createProduk.namaProduk = _namaProdukTextboxController.text;
          createProduk.hargaProduk = int.parse(_hargaProdukTextboxController.text);
          ProdukBloc.addProduk(produk: createProduk).then((value) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const ProdukPage()));
          }, onError: (error) {
            showDialog(
              context: context, 
              builder: (BuildContext context) =>  const WarningDialog(
                  description: 'Simpan gagal, silahkan coba lagi',
              ));
          });
          setState(() {
            _isLoading = false;
          });
      }

     produk_bloc.dart:
      static Future<List<Produk>>getProduks() async {
        String apiUrl = ApiUrl.listProduk;
        var response = await Api().get(apiUrl);
        var jsonObj = json.decode(response.body);
        List<dynamic>  listProduk = (jsonObj as Map<String, dynamic>)['data'];
        List<Produk> produks = [];
        for (int i = 0; i < listProduk.length; i++) {
          produks.add(Produk.fromJson(listProduk[i]));
        }
        return produks;
      }
     ```
     Penjelasan:
    - Produk createProduk = Produk(id: null) untuk membuat produk baru
    - createProduk.kodeProduk = _kodeProdukTextboxController.text;: untuk mengisi produk dari TextField
    - ProdukBloc.addProduk(produk: createProduk): mengirim data ke API
    - addProduk() artinya flutter akan melakukan POST request ke /produk.
    - API menambahkan data ke database
    - Jika berhasil kembali ke halaman list produk -> Navigator.push(...) dan flutter menampilkan popup sukses dan kembali ke halaman daftar produk
    - Jika gagal, tampilkan popup error -> showDialog(... WarningDialog ...);

7. Delete Produk<br>
    a. Screenshot delete produk<br>
    <img src="https://github.com/user-attachments/assets/b3d10177-f48d-41cb-b199-7f5c013c077c" width="200">
    <img src="https://github.com/user-attachments/assets/62627de6-6f18-428e-b872-762fede01713" width="200">
    <img src="https://github.com/user-attachments/assets/84255fd2-6b9c-419d-84d1-422199f313ae" width="200">
    <img src="https://github.com/user-attachments/assets/71b1e57f-df60-4ca9-a73c-b99318fbb05a" width="200">
    <br>Pertama user memilih produk, kemudian klik produk dan muncul halaman detail produk. pada halaman detail produk user dapat memilih apakah ingin mengedit atau hapus produk. ketika user klik tombol hapus maka akan muncul popup confirmHapus "Yakin ingin menghapus data ini?". jika klik iya makan data akan terhapus dan kembali ke halaman list produk.
   
     b. Kode delete produk<br>
     ```
     produk_bloc.dart
      static Future<bool> deleteProduk({int? id}) async {
        String apiUrl = ApiUrl.deleteProduk(id!);
    
        var response = await Api().delete(apiUrl);
        var jsonObj = json.decode(response.body);
        return (jsonObj as Map<String, dynamic>)['data'];
      }

     produk_detail.dart:
     void confirmHapus() {
      AlertDialog alertDialog = AlertDialog(
        content: const Text("Yakin ingin menghapus data ini?"),
        actions: [
          OutlinedButton(
            child: const Text('Ya'),
            onPressed: () {
              ProdukBloc.deleteProduk(id: int.parse(widget.produk!.id!)).then(
                (value) => {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder:(context) => const ProdukPage()))
                    }, onError: (error){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => const WarningDialog(
                          description: 'Hapus gagal, silahkan coba lagi',
                        ));
                });
                },
              ),
    
              //Tombol Batal
              OutlinedButton(
                child: const Text('Batal'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
    
        showDialog(builder: (context) => alertDialog, context: context);
        }
    }
     ```

     Penjelasan
    - Tentukan endpoint delete: /produk/{id}
    - Flutter kirim DELETE ke /produk/{id}
    - AlertDialog(content: Text("Yakin ingin menghapus data ini?")) untuk menampilkan dialog konfirmasi
    - Jika user klik “Ya”. artinya ambil ID produk yang ditampilkan pada halaman detail kemudian Kirim DELETE ke API
    - API hapus data di database
    - Jika berhasil kembali ke halaman list produk untuk menampilkan data terbaru.
    - Jika gagal maka WarningDialog(description: 'Hapus gagal, silahkan coba lagi') dan memunculkan popup error.

9. Ubah Produk<br>
    a. Screenshot ubah produk<br>
    <img src="https://github.com/user-attachments/assets/f2023cc6-7ca6-40fb-9a49-50cd61d0fe74" width="200">
    <img src="https://github.com/user-attachments/assets/0d0034b3-f63d-450b-85d7-b7790d32a53e" width="200">
    <img src="https://github.com/user-attachments/assets/19862d9d-3d82-490e-b66e-e2c1d082d123" width="200">
    <img src="https://github.com/user-attachments/assets/41c05c91-14ed-4358-b7ef-ad06af72d241" width="200">
    <br>Pertama user klik produk yang akan dipilih untuk pindah halaman detail produk. pada halaman detail produk klik tombol edit, kemudian akan muncul form dengan data produk yang akan diedit. ketika user klik tombol ubah maka data kan ter update dan kembali ke halaman list produk dengan data produk yang baru.<br>

     b. Kode tambah produk<br>
     ```
     static Future updateProduk({required Produk produk}) async {
        String apiUrl = ApiUrl.updateProduk(int.parse(produk.id!));
        print(apiUrl);
    
        var body = {
          'kode_produk': produk.kodeProduk,
          'nama_produk': produk.namaProduk,
          'harga': produk.hargaProduk.toString(),
        };
        print('Body: $body');
        var response = await Api().put(apiUrl, jsonEncode(body));
        var jsonObj = json.decode(response.body);
        return jsonObj['status'];
      }
     ```
   Penjelasan:
   - ApiUrl.updateProduk(id), dengan produk.id adalah ID produk yang sedang diedit.
   - Flutter load data lama ke TextField
   - ketika user klik simpann flutter kirim PUT request → /produk/{id}
   - API memperbarui data di database
   - return jsonObj['status'] untuk mengembalikan hasil ke halaman list produk
