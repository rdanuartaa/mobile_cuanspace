import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/makanan_model.dart';
import '../models/pesanan_model.dart';
import '../providers/pesanan_provider.dart';

class MakananPage extends StatelessWidget {
  const MakananPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Makanan")),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 Kolom
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8, // Ukuran grid agar tidak terlalu kecil
        ),
        itemCount: MakananModel.daftarMakanan.length,
        itemBuilder: (context, index) {
          final makanan = MakananModel.daftarMakanan[index];

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
                      makanan.gambar,
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
                        makanan.namaMakanan,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      Text("Rp ${makanan.harga}", style: TextStyle(color: const Color.fromARGB(255, 255, 126, 0))),
                      SizedBox(height: 5),

                      // Tombol Tambah dengan Update Pesanan
                      Consumer<PesananProvider>(
                        builder: (context, pesananProvider, child) {
                          int jumlahPesanan = pesananProvider.getJumlahPesanan(makanan.namaMakanan);
                          return Column(
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  pesananProvider.tambahPesanan(
                                    PesananModel(
                                      nama: makanan.namaMakanan,
                                      harga: makanan.harga,
                                      jumlah: 1,
                                      gambar: makanan.gambar,
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("${makanan.namaMakanan} ditambahkan!")),
                                  );
                                },
                                icon: Icon(Icons.add_shopping_cart),
                                label: Text("Tambah"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 255, 126, 0),
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
