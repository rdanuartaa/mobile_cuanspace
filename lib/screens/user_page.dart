import 'package:cuan_space/screens/login_page.dart';
import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/user_model.dart';


class UserPage extends StatefulWidget {
  final String username; // Ambil username dari login

  const UserPage({super.key, required this.username});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  User? _user;
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  // Fungsi untuk mengambil data user dari database berdasarkan username
  void _fetchUserData() async {
    User? user = await dbHelper.getUserByUsername(widget.username);
    setState(() {
      _user = user;
    });
  }

  // Fungsi untuk logout dan kembali ke halaman login
  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi Logout"),
        content: const Text("Apakah Anda yakin ingin logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Tutup dialog
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()), // Arahkan ke halaman login
                (route) => false, // Menghapus semua halaman sebelumnya
              );
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Profile")),
      body: _user == null
          ? const Center(child: CircularProgressIndicator()) // Loading jika data belum diambil
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Card untuk menampilkan informasi user
                  Card(
                    elevation: 4, // Memberikan efek bayangan
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.blue,
                            child: Text(
                              _user!.namaLengkap[0], // Inisial dari nama
                              style: const TextStyle(fontSize: 40, color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _user!.namaLengkap,
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "@${_user!.username}",
                            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ListTile untuk detail informasi user
                  _buildInfoTile(Icons.email, "Email", _user!.email),
                  _buildInfoTile(Icons.phone, "No HP", _user!.noHp.toString()),
                  _buildInfoTile(Icons.cake, "Tanggal Lahir", _user!.tanggalLahir),
                  _buildInfoTile(Icons.location_on, "Alamat", _user!.alamat),
                  _buildInfoTile(Icons.person, "Jenis Kelamin", _user!.jenisKelamin),

                  const Spacer(), // Untuk mendorong tombol ke bawah
                  
                  // Tombol Logout
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Warna tombol merah
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: _logout,
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text("Logout", style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // Widget untuk ListTile informasi user
  Widget _buildInfoTile(IconData icon, String title, String value) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }
}
