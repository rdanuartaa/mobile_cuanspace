import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    AdvertisementScreen(),
    CommunityScreen(),
    SupportScreen(),
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
        title: Text('Cuanspace'),
        backgroundColor: Colors.orange,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Icon(Icons.person, size: 40, color: Colors.orange),
                  ),
                  SizedBox(height: 10),
                  Text('User Name',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.campaign),
              title: Text('Iklan UMKM'),
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.groups),
              title: Text('Forum Komunitas'),
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.support),
              title: Text('Dukungan & Bantuan'),
              onTap: () {
                _onItemTapped(3);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.campaign), label: 'Iklan'),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: 'Komunitas'),
          BottomNavigationBarItem(icon: Icon(Icons.support), label: 'Dukungan'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Beranda: Promo UMKM & Kategori Iklan'));
  }
}

class AdvertisementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Iklan UMKM: Pasang & Kelola Iklan Anda'));
  }
}

class CommunityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Forum Komunitas: Networking & Event UMKM'));
  }
}

class SupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Dukungan & Bantuan: FAQ & Kontak Support'));
  }
}
