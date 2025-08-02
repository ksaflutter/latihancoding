void main() {
  // tugas 1 - menampilkan tipe data boolean
  print("menampilkan tipe data boolean");
  var name = "Nugi Kresno";
  bool isMale = true;
  print("$name adalah laki-laki: $isMale"); // Nugi

  var nameHer = "Sinta Hapsari";
  bool isHer = true;
  print(
    "$nameHer adalah perempuan: $isHer",
  ); /* Sinta Hapsari adalah laki-laki: false
  jadi apapun namanya boleh saja mau isHer mau perempuan atau laki-laki*/

  // tugas 2 - menampilkan tipe data boolean dan number
  print("\n\nmenampilkan tipe data boolean dan number");
  print(
    "$nameHer adalah perempuan: $isHer",
  ); // Sinta Hapsari adalah perempuan: true
  double age = 25.5; // nga bisa pakai int karena ada koma
  print("$nameHer berusia: $age"); /* Sinta Hapsari berusia: 25.5
  untuk number bisa pakai int atau double */

  int height = 160;
  print(
    "$nameHer memiliki tinggi: $height cm",
  ); // Sinta Hapsari memiliki tinggi: 160 cm

  // tugas 3 - menampilkan tipe data number dengan parameter
  print("\n\nmenampilkan tipe number dengan parameter");
  double weight = -55.5;

  print(
    "$nameHer beratnya: ${weight.abs()} kg" /* abs mengambil nilai absolut
    jadi nga peduli positif atau negatif, tetap akan menampilkan angka positif */,
  ); // Sinta Hapsari memiliki berat: 55.5 kg
}
