import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../providers/pesanan_provider.dart';
import '../models/pesanan_model.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pesananProvider = Provider.of<PesananProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Pesanan Saya")),
      body: pesananProvider.pesanan.isEmpty
          ? Center(child: Text("Belum ada pesanan"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: pesananProvider.pesanan.length,
                    itemBuilder: (context, index) {
                      final pesanan = pesananProvider.pesanan[index];

                      return ListTile(
                        leading: Image.asset(
                          pesanan.gambar,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(pesanan.nama),
                        subtitle: Text(
                          "Jumlah: ${pesanan.jumlah} - Total: Rp ${pesanan.harga * pesanan.jumlah}",
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove, color: Colors.red),
                              onPressed: () {
                                pesananProvider.kurangiPesanan(pesanan.nama);
                              },
                            ),
                            Text(
                              pesanan.jumlah.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: Icon(Icons.add, color: Colors.green),
                              onPressed: () {
                                pesananProvider.tambahPesanan(PesananModel(
                                  nama: pesanan.nama,
                                  harga: pesanan.harga,
                                  jumlah: 1, // Tambah jumlah 1
                                  gambar: pesanan.gambar,
                                ));
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Divider dengan teks putih
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.white,
                          thickness: 1.5,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "Total Pembayaran",
                          style: TextStyle(
                            color: Colors.white, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.white,
                          thickness: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // Bagian total harga dan tombol bayar
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Total: Rp ${pesananProvider.totalHarga}",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: pesananProvider.hapusSemuaPesanan,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              ),
                            child: Text("Hapus Semua"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (pesananProvider.totalHarga > 0) {
                                _tampilkanDialogBayar(context);
                                pesananProvider.hapusSemuaPesanan();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              ),
                            child: Text("Bayar"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  // Fungsi untuk menampilkan animasi dialog saat bayar
  void _tampilkanDialogBayar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return _AnimatedDialog();
      },
    );

    // Tutup dialog otomatis setelah 3 detik
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pop();
    });
  }
}

// Widget dialog dengan animasi
class _AnimatedDialog extends StatefulWidget {
  @override
  __AnimatedDialogState createState() => __AnimatedDialogState();
}

class __AnimatedDialogState extends State<_AnimatedDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showText = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();

    // Delay untuk menampilkan teks dengan efek fade-in
    Future.delayed(Duration(milliseconds: 600), () {
      setState(() {
        _showText = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 60),
            SizedBox(height: 10),
            AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: _showText ? 1.0 : 0.0,
              child: Column(
                children: [
                  Text(
                    "Terima Kasih Sudah Memesan!",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Silakan tunggu sebentar, pesananmu segera kami antar.",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
