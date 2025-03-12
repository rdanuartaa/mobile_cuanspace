import 'package:flutter/material.dart';
import 'home_page.dart';
import 'notification_page.dart';
import 'orders_page.dart';
import 'user_page.dart';

class DashboardPage extends StatefulWidget {
  final String username; // Menerima username dari LoginPage

  const DashboardPage({super.key, required this.username});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // List halaman dengan username dikirim ke UserPage
    final List<Widget> _pages = [
      HomePage(),
      NotificationPage(),
      OrdersPage(),
      UserPage(username: widget.username), // Kirim username ke UserPage
    ];

    return Scaffold(
      body: _pages[_selectedIndex], // Pastikan ini mengambil halaman yang sesuai
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black, // Warna item yang dipilih
        unselectedItemColor: Colors.black, // Warna item yang tidak dipilih
        backgroundColor: Colors.white, // Pastikan background putih agar kontras
        type: BottomNavigationBarType.fixed, // Agar semua item tetap terlihat
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black), 
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Colors.black), 
            label: "Notifikasi",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.black), 
            label: "Pesanan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black), 
            label: "User",
          ),
        ],
      ),
    );
  }
}
