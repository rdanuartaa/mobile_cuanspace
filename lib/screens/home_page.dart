import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeContent(),
    FiturCepatPage(),
    LainnyaPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cuanspace - UMKM Jember'),
        backgroundColor: Colors.orangeAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.orangeAccent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.account_circle, size: 60, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    "Halo, Pelaku UMKM!",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.local_offer),
              title: Text('Promo'),
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.flash_on),
              title: Text('Fitur Cepat'),
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.more_horiz),
              title: Text('Lainnya'),
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flash_on),
            label: 'Fitur Cepat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'Lainnya',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orangeAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Halaman Utama dengan tambahan fitur
class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Promo
          CarouselSlider(
            options: CarouselOptions(height: 180.0, autoPlay: true),
            items: [
              'assets/promo1.jpg',
              'assets/promo2.jpg',
              'assets/promo3.jpg'
            ].map((image) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),

          SizedBox(height: 10),

          // Kategori UMKM
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Kategori UMKM',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            children: [
              _buildCategoryTile(Icons.restaurant, 'Kuliner'),
              _buildCategoryTile(Icons.shopping_bag, 'Fashion'),
              _buildCategoryTile(Icons.build, 'Jasa'),
              _buildCategoryTile(Icons.store, 'Lainnya'),
            ],
          ),

          SizedBox(height: 10),

          // UMKM Terpopuler
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('UMKM Terpopuler',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildUMKMCard('Bakso Jember', 'assets/bakso.jpg'),
                _buildUMKMCard('Batik Tulis', 'assets/batik.jpg'),
                _buildUMKMCard('Kopi Jember', 'assets/kopi.jpg'),
              ],
            ),
          ),

          SizedBox(height: 10),

          // Berita & Edukasi UMKM
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Berita & Edukasi UMKM',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          _buildNewsTile(
              'Cara Meningkatkan Penjualan Online', 'Baca selengkapnya'),
          _buildNewsTile(
              'Strategi Digital Marketing untuk UMKM', 'Baca selengkapnya'),
        ],
      ),
    );
  }

  Widget _buildCategoryTile(IconData icon, String label) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.orange),
            SizedBox(height: 5),
            Text(label, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildUMKMCard(String name, String image) {
    return Container(
      width: 120,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: Colors.black54,
          width: double.infinity,
          padding: EdgeInsets.all(5),
          child: Text(name, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildNewsTile(String title, String actionText) {
    return ListTile(
      title: Text(title),
      trailing: TextButton(
        onPressed: () {},
        child: Text(actionText, style: TextStyle(color: Colors.orange)),
      ),
    );
  }
}

// Halaman lainnya
class FiturCepatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Fitur Cepat UMKM"));
  }
}

class LainnyaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Layanan Lainnya"));
  }
}
