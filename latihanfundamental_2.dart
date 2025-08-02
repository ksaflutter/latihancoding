void main() {
  // Set untuk menyimpan angka unik
  print("set angka unik");
  Set<int> angkaUnik = {1, 2, 2, 3};
  // Menyimpan data yang harus unik, tidak peduli urutan, tidak bisa ada data yang sama.

  // Set otomatis menghilangkan duplikat
  print(angkaUnik); // {1, 2, 3}

  // List untuk menyimpan nilai ujian
  print("\n\nlist nilai ujian");
  List<int> nilaiUjian = [80, 90, 80, 100];
  // List menyimpan data berurutan, bisa ada data yang sama, bisa diakses dengan indeks
  print(nilaiUjian); // [80, 90, 80, 100]
  print(nilaiUjian[1]); // 90 (akses data pakai indeks)

  // Set untuk peserta hadir
  print("\n\nset peserta hadir");
  Set<String> pesertaHadir = {"Budi", "Siti", "Budi", "Andi"};
  print(pesertaHadir); // {"Budi", "Siti", "Andi"} (otomatis hilangkan duplikat)
}
