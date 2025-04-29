class PesananModel {
  String nama;
  int harga;
  int jumlah;
  String gambar;

  PesananModel({
    required this.nama,
    required this.harga,
    required this.jumlah,
    required this.gambar,
  });

  int get totalHarga => harga * jumlah;
}
