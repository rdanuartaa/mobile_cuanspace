class User {
  int? id;
  String namaLengkap;
  String username;
  String email;
  int noHp;
  String tanggalLahir;
  String alamat;
  String jenisKelamin;
  String password;

  User({
    this.id,
    required this.namaLengkap,
    required this.username,
    required this.email,
    required this.noHp,
    required this.tanggalLahir,
    required this.alamat,
    required this.jenisKelamin,
    required this.password,
  });

  // Konversi ke Map untuk disimpan di SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama_lengkap': namaLengkap,
      'username': username,
      'email': email,
      'no_hp': noHp,
      'tanggal_lahir': tanggalLahir,
      'alamat': alamat,
      'jenis_kelamin': jenisKelamin,
      'password': password,
    };
  }

  // Konversi dari Map ke Object User
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      namaLengkap: map['nama_lengkap'],
      username: map['username'],
      email: map['email'],
      noHp: map['no_hp'],
      tanggalLahir: map['tanggal_lahir'],
      alamat: map['alamat'],
      jenisKelamin: map['jenis_kelamin'],
      password: map['password'],
    );
  }
}
