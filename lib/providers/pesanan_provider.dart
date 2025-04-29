import 'package:flutter/material.dart';
import '../models/pesanan_model.dart';

class PesananProvider with ChangeNotifier {
  List<PesananModel> _pesanan = [];

  List<PesananModel> get pesanan => _pesanan;

  int get totalHarga => _pesanan.fold(0, (total, item) => total + (item.harga * item.jumlah));

  int getJumlahPesanan(String nama) {
    final item = _pesanan.firstWhere(
      (p) => p.nama == nama,
      orElse: () => PesananModel(nama: "", harga: 0, jumlah: 0, gambar: ""),
    );
    return item.jumlah;
  }

  void tambahPesanan(PesananModel item) {
    int index = _pesanan.indexWhere((p) => p.nama == item.nama);
    if (index != -1) {
      _pesanan[index].jumlah++; // Tambah jumlah
    } else {
      _pesanan.add(item);
    }
    notifyListeners();
  }

  void kurangiPesanan(String nama) {
    int index = _pesanan.indexWhere((p) => p.nama == nama);
    if (index != -1) {
      if (_pesanan[index].jumlah > 1) {
        _pesanan[index].jumlah--; // Kurangi jumlah
      } else {
        _pesanan.removeAt(index); // Hapus jika jumlah 1
      }
      notifyListeners();
    }
  }

  void hapusPesanan(String nama) {
    _pesanan.removeWhere((item) => item.nama == nama);
    notifyListeners();
  }

  void hapusSemuaPesanan() {
    _pesanan.clear();
    notifyListeners();
  }
}
