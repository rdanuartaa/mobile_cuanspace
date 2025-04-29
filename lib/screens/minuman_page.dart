import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/minuman_model.dart';
import '../models/pesanan_model.dart';
import '../providers/pesanan_provider.dart';

class MinumanPage extends StatelessWidget {
  const MinumanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Minuman")),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 Kolom
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: MinumanModel.daftarMinuman.length,
        itemBuilder: (context, index) {
          final minuman = MinumanModel.daftarMinuman[index];

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.asset(
                      minuman.gambar,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.broken_image, size: 100, color: Colors.grey);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(
                        minuman.namaMinuman,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      Text("Rp ${minuman.harga}", style: TextStyle(color: const Color.fromRGBO(255, 126, 0, 0))),
                      SizedBox(height: 5),
                      Text(
                        minuman.jenisMinuman == "hotdrink" ? "☕ Hot Drink" : "🧊 Ice Drink",
                        style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                      ),
                      SizedBox(height: 5),

                      // Tambahkan dengan Provider
                      Consumer<PesananProvider>(
                        builder: (context, pesananProvider, child) {
                          int jumlahPesanan = pesananProvider.getJumlahPesanan(minuman.namaMinuman);
                          return Column(
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  pesananProvider.tambahPesanan(
                                    PesananModel(
                                      nama: minuman.namaMinuman,
                                      harga: minuman.harga,
                                      jumlah: 1,
                                      gambar: minuman.gambar,
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("${minuman.namaMinuman} ditambahkan!")),
                                  );
                                },
                                icon: Icon(Icons.add_shopping_cart),
                                label: Text("Tambah"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(255, 126, 0, 0),
                                  foregroundColor: Colors.white,
                                ),
                              ),

                              // Menampilkan jumlah pesanan
                              if (jumlahPesanan > 0)
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Dipesan: $jumlahPesanan",
                                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
