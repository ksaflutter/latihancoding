void main() {
  // tugas belajar fundamental dart
  // menampilkan string expresion
  // dan variabel
  print("\n\nTugas Belajar Fundamental Dart");
  int umur = 48;
  var nama = "Nugi";
  print("nama saya = $nama"); // menggunakan string interpolation
  print("umur saya = $umur"); // & disini menampilkan data variabel umur

  // tugas 1 - menampilkan tipe data string
  print("\n\n\Tugas 1 - menampilkan String interpolasi");

  String namaLengkap = "Kresno Suci A";
  print("nama saya : $namaLengkap");

  // tugas 2 - menampilkan tipe data string - pakai string non variable
  print("\n\nTugas 2 - menampilkan String lower upper case");

  String namaKecil = "nugi";
  String namaBesar = "Kresno";
  print("nama kecil : ${namaKecil.toLowerCase()}"); // buka dengan to
  print("nama besar : ${namaBesar.toUpperCase()}");

  // tugas 3 - menampilkan tipe data string - pakai string non variable
  print("\n\nTugas 3 - menampilkan String dengan karakter khusus");

  String teks = "Kresno Suci A";
  print("teks : $teks");
  print("teks dengan karakter khusus : ${teks.replaceAll(' ', '_')}");
  // buka dengan replaceAll

  // tugas 4 - menampilkan tipe data string - karakter khusus dan uppercase
  print(
    "\n\nTugas 4 - menampilkan String dengan karakter khusus gabung uppercase",
  );

  String tulisan = "Abu Djalaluddin";
  print("tulisan : $tulisan");
  print(
    "tulisan dengan karakter dan upper : ${tulisan.replaceAll(' ', '_').toUpperCase()}",
  );
  // Abu_Djalaluddin
}
