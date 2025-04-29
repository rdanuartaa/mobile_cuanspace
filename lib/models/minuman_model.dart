// ignore_for_file: public_member_api_docs, sort_constructors_first
class MinumanModel {
  String namaMinuman;
  String jenisMinuman;
  int harga;
  String gambar;

  MinumanModel({
    required this.namaMinuman,
    required this.jenisMinuman,
    required this.harga,
    required this.gambar,
  });

  static List<MinumanModel> daftarMinuman = [
    MinumanModel(
      namaMinuman: 'Wedang Jahe', 
      jenisMinuman: 'hotdrink', 
      harga: 6000, 
      gambar: 'assets/wedangjahe.jpg'
      ),
    MinumanModel(
      namaMinuman: 'Es Cendol', 
      jenisMinuman: 'icedrink', 
      harga: 8000, 
      gambar: 'assets/escendol.jpg'
      ),
    MinumanModel(
      namaMinuman: 'Kopi Syahdu', 
      jenisMinuman: 'hotdrink', 
      harga: 7000, 
      gambar: 'assets/kopisyahdu.jpg'
      ),
    MinumanModel(
      namaMinuman: 'Jus Jeruk', 
      jenisMinuman: 'icedrink', 
      harga: 10000, 
      gambar: 'assets/jusjeruk.jpg'
      ),
    MinumanModel(
      namaMinuman: 'Wedang Ronde', 
      jenisMinuman: 'hotdrink', 
      harga: 8000, 
      gambar: 'assets/wedangronde.jpg'
      ),
    MinumanModel(
      namaMinuman: 'Es Teller', 
      jenisMinuman: 'icedrink', 
      harga: 15000, 
      gambar: 'assets/esteller.jpg'
      ),
  ];
}
