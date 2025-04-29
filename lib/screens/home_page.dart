import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cuan Space"),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          // Banner Promo
          Container(
            width: double.infinity,
            height: 150,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.orange[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                "Promo Spesial UMKM!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),

          // Daftar UMKM
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: [
                _buildUmkmCard("Bakso Malang Pak Joko", "Jl. Merdeka No. 10"),
                _buildUmkmCard("Ayam Geprek Bu Siti", "Jl. Diponegoro No. 15"),
                _buildUmkmCard("Kopi Kenangan Kita", "Jl. Sudirman No. 22"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUmkmCard(String nama, String alamat) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(Icons.store, color: Colors.orange),
        title: Text(nama, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(alamat),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Bisa ditambahkan navigasi ke detail UMKM kalau diperlukan
        },
      ),
    );
  }
}
