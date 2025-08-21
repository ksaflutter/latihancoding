import 'package:shared_preferences/shared_preferences.dart'; // // Mengimpor package SharedPreferences untuk menyimpan data sederhana (key-value) di device.

class AuthPreferences {
  static const String _keyIsLoggedIn =
      'is_logged_in'; // Kunci (key) untuk menyimpan status login user (true/false).
  static const String _keyUsername =
      'username'; // Kunci untuk menyimpan username.
  static const String _keyEmail = 'email'; // // Kunci untuk menyimpan email.
  static const String
      _keyUserPassword = // Kunci untuk menyimpan password (CATATAN: praktik ini TIDAK aman untuk produksi)
      'user_password';
  // Login user
  static Future<bool> loginUser(
      String username, String email, String password) async {
    // Method statis untuk proses login. Mengembalikan true jika berhasil.
    final prefs = await SharedPreferences
        .getInstance(); // Mengambil instance SharedPreferences (singleton, async).
    //Di validasi lebih dulu
    final savedEmail = prefs.getString(_keyEmail) ??
        ''; // Membaca email yang sudah disimpan; jika null, fallback ke string kosong.
    final savedPassword = prefs.getString(_keyUserPassword) ??
        ''; // Membaca password yang sudah disimpan; jika null, fallback ke string kosong.
    // Simple validation
    if (email == savedEmail && password == savedPassword) {
      // Membandingkan input login dengan data yang tersimpan.
      // jika sudah match, set isLoggedIn ke true
      await prefs.setBool(
          _keyIsLoggedIn, true); // Menandai bahwa user kini berstatus login.
      return true; // Mengembalikan hasil sukses.
    }
    return false; // Jika tidak cocok, login gagal.
  }

  // Register user
  static Future<bool> registerUser(
      String username, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    // Simple validation
    if (username.isNotEmpty && email.isNotEmpty && password.length >= 6) {
      // Validasi sederhana: semua field terisi dan password minimal 6 karakter.
      await prefs.setBool(_keyIsLoggedIn,
          true); // Setelah register, langsung tandai sebagai login (opsional, tergantung kebijakan app)
      await prefs.setString(_keyUsername, username); // Simpan username.
      await prefs.setString(_keyEmail, email); // Simpan email.
      await prefs.setString(_keyUserPassword, password); // Simpan password.
      return true;
    }
    return false; // Registrasi gagal jika validasi tidak lolos.
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    // Mengecek status login saat ini.
    final prefs = await SharedPreferences
        .getInstance(); // Mengambil instance SharedPreferences.
    return prefs.getBool(_keyIsLoggedIn) ??
        false; // Baca nilai boolean; default false jika belum pernah diset
  }

  // Get current username
  static Future<String> getUsername() async {
    // Mendapatkan username tersimpan.
    final prefs = await SharedPreferences.getInstance(); // Ambil instance.
    return prefs.getString(_keyUsername) ??
        'User'; // Kembalikan username, default 'User' jika kosong.
  }

  // Get current email
  static Future<String> getEmail() async {
    // Mendapatkan email tersimpan.
    final prefs = await SharedPreferences.getInstance(); // Ambil instance.
    return prefs.getString(_keyEmail) ??
        ''; // Kembalikan email, default string kosong jika tidak ada.
  }

  // Logout user
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn,
        false); // Set status login menjadi false (tidak menghapus username/email/password).
  }

  // Validate login credentials
  static Future<bool> validateCredentials(String email, String password) async {
    // Memvalidasi kredensial tanpa mengubah status login
    final prefs = await SharedPreferences.getInstance(); // Ambil instance.
    final savedEmail = prefs.getString(_keyEmail) ?? ''; // Baca email tersimpan
    final savedPassword =
        prefs.getString(_keyUserPassword) ?? ''; // Baca password tersimpan
    return email == savedEmail &&
        password == savedPassword; // True jika email & password cocok
  }

  // Check if user exists (for registration)
  static Future<bool> userExists(String email) async {
    // Mengecek apakah user dengan email tertentu "sudah ada"
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString(_keyEmail) ?? '';
    return savedEmail ==
        email; // True jika email yang dicek sama dengan email tersimpan.
  } // (Catatan: ini hanya mendukung satu user tersimpan, bukan multi-user.)
}
