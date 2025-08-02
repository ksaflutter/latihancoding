void main() {
  String nama = "nugi kresno"; // nama mahasiswa
  nama = "Elon Musk";
  print(nama); // Output: Elon Musk penggantian nama

  // tugas 1 - menampilkan tipe data dengan final
  print("\n\nTugas 1 - menampilkan data dengan final");
  final String namaLengkap = "Kresno Suci A";
  nama = "Elon Jawa";
  print("nama saya tetap : $namaLengkap"); // Output: nama saya : Kresno Suci A
  // contoh final : final now = DateTime.now();

  // tugas 2 - menampilkan tipe data dengan constant
  print("\n\nTugas 2 - menampilkan data dengan constant");
  const String namaKecil = "nugi";
  nama = "Elon kecil";
  print("nama kecil saya : $namaKecil"); // Output: nama kecil saya : nugi
  // keduanya tidak bisa diganti karena final dan const
  // kalau final bisa disimpan dulu baru diganti

  /* keduanya dipakai untuk membuat variabel yang nilainya
  tidak bisa diubah setelah di-set. */
}
