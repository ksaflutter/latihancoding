void main() {
  // Set untuk menyimpan angka unik
  print("set angka unik");
  Set<int> angkaUnik = {1, 2, 2, 3};
  print(angkaUnik); // {1, 2, 3}

  // List untuk menyimpan nilai ujian
  print("\n\nlist nilai ujian");
  List<int> nilaiUjian = [80, 90, 80, 100];
  print(nilaiUjian); // [80, 90, 80, 100]
  print(nilaiUjian[1]); // 90 (akses data pakai indeks)

  // Set untuk peserta hadir
  print("\n\nset peserta hadir");
  Set<String> pesertaHadir = {"Budi", "Siti", "Budi", "Andi"};
  print(pesertaHadir); // {"Budi", "Siti", "Andi"} (otomatis hilangkan duplikat)
}
