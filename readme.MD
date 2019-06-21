Untuk menjalankan program gunakan Go-Eat.rb

Program yang saya buat ini menggunakan aturan x,y tapi dengan aturan x=kolom dan y=baris, alias x disini merupakan y di diagram kartesius, y disini merupakan x di diagram kartesius. Saya mendesain seperti ini agar memudahkan saya dalam membuat posisi benda bendanya karena saya menggunakan array 2 dimensi.

Di dalam mendesain program ini, saya menggunakan OOP dengan file terpisah agar membuat program saya menjadi modular, sehingga dapat mempermudah debugging dan maintenance apabila ada fitur yang kurang.

Alur dari program ini ialah program pertama kali membuat instance User, instance User tersebut akan memulai class App untuk processing logic nya dan class CLI untuk interface nya.

Saya mendesain program ini layaknya seperti aplikasi yang memiliki Backend dan Front End karena dengan seperti itu saya tidak bingung akan memodifikasi tiap tiap fungsi yang berjalan, serta dengan cara ini program ini memiliki alur yang jelas seperti apabila membutuhkan data user akan memberi input ke CLI lalu CLI tersebut mengambil datanya ke class App, class App akan mengembalikan datanya untuk ditampilkan ke CLI.

Ada beberapa bagian yang langsung bisa request ke class User contohnya objek Order. Objek ini diperuntukkan menyimpan data Order User, seperti driver, toko, items, dan rute pengiriman

Di dalam peta saya anggap tiap titik dari suatu peta merupakan object karena itu dapat memudahkan saya dalam mengambil data yang ada dalam titik itu seperti Object aktif yang berada pada titik itu.

Ukuran Peta Minimal 7*7 satuan (apabila tidak menggunakan file), saya mensetting node yang random supaya mengosongkan area disekelilingnya pada saat digenerate.

Setiap toko dapat diakses dari segala macam arah(kanan,kiri,atas,bawah)

Setiap driver dapat melintasi driver dan User, disini saya menganggap satu node merupakan 2 ruas jalan. Tetapi driver tidak dapat melintasi Toko

Setiap driver yang di generate memiliki rating awal 4.0
