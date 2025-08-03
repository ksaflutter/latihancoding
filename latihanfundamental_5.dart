void main() {
  // contoh penggunaan void selain main
  // melempar argumen ke fungsi (melempar data ke fungsi)
  penjumlahan(5, 10); // buat parameter sendiri untuk memanggil fungsi
  pengurangan(20, 5); // buat parameter sendiri untuk memanggil fungsi
  // contoh penggunaan void main

  int hasilPerkalian = perkalian(
    5,
    10,
  ); // perintah hasil didalam fungsi (perkalian)
  print("Hasil perkalian: $hasilPerkalian"); // Hasil perkalian: 50
} // ini yang membedakan fungsi main dengan fungsi lainnya

void penjumlahan(int a, int b) {
  // fungsi penjumlahan
  print("Hasil penjumlahan $a + $b = ${a + b}"); // hasil diluar fungsi
}

void pengurangan(int a, int b) {
  // fungsi pengurangan
  print("Hasil pengurangan $a - $b = ${a - b}");
}

int perkalian(int a, int b) {
  // tidak bisa pakai void karena mengembalikan nilai
  // fungsi perkalian
  return a * b; // mengembalikan hasil perkalian
}
