class Validators {
  static String? validateRequired(String? value) {
    return value == null || value.isEmpty ? "Field tidak boleh kosong" : null;
  }

  static String? validateEmail(String? value) {
    return value != null && !RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)
        ? "Email tidak valid"
        : null;
  }

  static String? validatePhone(String? value) {
    return value != null && !RegExp(r"^[0-9]{10,13}$").hasMatch(value)
        ? "Nomor HP tidak valid"
        : null;
  }

  static String? validatePassword(String? value) {
    return value != null && value.length < 6 ? "Password minimal 6 karakter" : null;
  }
}
