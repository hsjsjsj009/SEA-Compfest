*Untuk menjalankan program gunakan Go-Eat.rb*

Titik 0,0 pada program ini ialah titik kiri atas.

Di dalam mendesain program ini, saya menggunakan OOP dengan file terpisah agar membuat program saya menjadi modular, sehingga dapat mempermudah debugging dan maintenance apabila ada fitur yang kurang.

Alur dari program ini ialah program pertama kali membuat instance User, instance User tersebut akan memulai class App untuk processing logic nya dan class CLI untuk interface nya.

Saya mendesain program ini layaknya seperti aplikasi yang memiliki Backend dan Front End karena dengan seperti itu saya tidak bingung akan memodifikasi tiap tiap fungsi yang berjalan, serta dengan cara ini program ini memiliki alur yang jelas seperti apabila membutuhkan data user akan memberi input ke CLI lalu CLI tersebut mengambil datanya ke class App, class App akan mengembalikan datanya untuk ditampilkan ke CLI.

Ada beberapa bagian yang langsung bisa request ke class User contohnya objek Order. Objek ini diperuntukkan menyimpan data Order User, seperti driver, toko, items, dan rute pengiriman

Di dalam peta saya anggap tiap titik dari suatu peta merupakan object karena itu dapat memudahkan saya dalam mengambil data yang ada dalam titik itu seperti Object aktif yang berada pada titik itu.

Ukuran Peta saya perkirakan Minimal 7*7 satuan (apabila tidak menggunakan file), saya mensetting node yang random supaya mengosongkan area disekelilingnya pada saat digenerate.

Setiap toko dapat diakses dari segala macam arah(kanan,kiri,atas,bawah)

Setiap driver dapat melintasi driver dan User, disini saya menganggap satu node merupakan 2 ruas jalan. Tetapi driver tidak dapat melintasi Toko

Saya kurang paham tentang perhitungan biaya perjalanan driver sehingga saya menghitung jarak dari store ke user lalu dikalikan dengan price per unit dari Driver.

File history bernama history.txt

Saya menata data sedemikian rupa agar dapat di baca jelas datanya. Tertera Store, Food List(dengan perhitungan biayanya), dan juga delivery cost beserta panjang units nya, serta ada juga total price untuk harga seluruh total belanjaanya. Driver yang melakukan order juga saya tulis agar dapat tahu driver yang melakukan order tersebut siapa. Rute ditulis sedemikian rupa agar jelas step step nya. Saya menuliskan lokasi store dan user di history supaya dapat diketahui lokasi asalnya.

Contoh inputan file bisa dilihat di input.txt, saya mengambil desain inputan file seperti itu agar dapat dibaca jelas oleh manusia dan mesin. Data dibagi menjadi 5 segmen yaitu Map,User,Driver,Store,dan Food, setiap segmen diawali dengan huruf besar. Untuk mengakhiri segmen ditambahkan kata "end" agar program dapat tahu kalau segmen tersebut telah selesai.

Untuk pathfinder nya saya menggunakan algoritma A* Search karena algoritma tersebut lumayan cepat dalam mencari path dan juga peka terhadap halangan(Store).

Program ini akan menggenerate file history dengan nama yang berbeda tiap kali dijalankan.