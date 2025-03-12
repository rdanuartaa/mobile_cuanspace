import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../database/database_helper.dart';
import '../models/user_model.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  TextEditingController _namaController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _noHpController = TextEditingController();
  TextEditingController _tanggalLahirController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  String _selectedGender = 'Laki-laki';

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _tanggalLahirController.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      User newUser = User(
        namaLengkap: _namaController.text,
        username: _usernameController.text,
        email: _emailController.text,
        noHp: int.parse(_noHpController.text),
        tanggalLahir: _tanggalLahirController.text,
        alamat: _alamatController.text,
        jenisKelamin: _selectedGender,
        password: _passwordController.text,
      );

      await dbHelper.registerUser(newUser);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registrasi Berhasil! Silakan Login")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Menampilkan SVG di tengah atas
                SvgPicture.asset(
                  "assets/Vector.svg",
                  height: 100, // Sesuaikan ukuran
                ),
                const SizedBox(height: 40),

                // Form Registrasi
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _namaController,
                        decoration: InputDecoration(labelText: "Nama Lengkap"),
                        validator: (value) => value == null || value.isEmpty ? 'Nama lengkap harus diisi' : null,
                      ),
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(labelText: "Username"),
                        validator: (value) => value == null || value.isEmpty ? 'Username harus diisi' : null,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(labelText: "Email"),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email harus diisi';
                          } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                            return 'Format email tidak valid';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _noHpController,
                        decoration: InputDecoration(labelText: "No HP"),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'No HP harus diisi';
                          } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'No HP hanya boleh angka';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _tanggalLahirController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Tanggal Lahir",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () => _selectDate(context),
                          ),
                        ),
                        validator: (value) => value == null || value.isEmpty ? 'Tanggal lahir harus diisi' : null,
                      ),
                      TextFormField(
                        controller: _alamatController,
                        decoration: InputDecoration(labelText: "Alamat"),
                        validator: (value) => value == null || value.isEmpty ? 'Alamat harus diisi' : null,
                      ),
                      DropdownButtonFormField(
                        value: _selectedGender,
                        items: ["Laki-laki", "Perempuan"]
                            .map((String gender) => DropdownMenuItem(
                                  value: gender,
                                  child: Text(gender),
                                ))
                            .toList(),
                        onChanged: (value) => setState(() => _selectedGender = value!),
                        decoration: InputDecoration(labelText: "Jenis Kelamin"),
                        validator: (value) => value == null ? 'Pilih jenis kelamin' : null,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(labelText: "Password"),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password harus diisi';
                          } else if (value.length < 6) {
                            return 'Password minimal 6 karakter';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(labelText: "Konfirmasi Password"),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Konfirmasi password harus diisi';
                          } else if (value != _passwordController.text) {
                            return 'Konfirmasi password tidak cocok';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Tombol Register
                      ElevatedButton(
                        onPressed: _register,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text("Register"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
