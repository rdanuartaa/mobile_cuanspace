// ignore_for_file: public_member_api_docs, sort_constructors_first
class MakananModel {
  String namaMakanan;
  int harga;
  String gambar;

  MakananModel({
    required this.namaMakanan,
    required this.harga,
    required this.gambar,
  });

  static List<MakananModel> daftarMakanan = [
    MakananModel(
      namaMakanan: "Nasi Goreng",
      harga: 15000,
      gambar: "assets/nasgor.jpg",
    ),
    MakananModel(
      namaMakanan: "Mie Ayam",
      harga: 12000,
      gambar: "assets/mieayam.jpg",
    ),
    MakananModel(
      namaMakanan: "Ayam Geprek",
      harga: 17000,
      gambar: "assets/geprek.jpg",
    ),
    MakananModel(
      namaMakanan: "Bakso",
      harga: 17000,
      gambar: "assets/bakso.jpg",
    ),
    MakananModel(
      namaMakanan: "Soto",
      harga: 17000,
      gambar: "assets/soto.jpg",
    ),
    MakananModel(
      namaMakanan: "Rawon",
      harga: 17000,
      gambar: "assets/rawon.jpg",
    ),
  ];
}
