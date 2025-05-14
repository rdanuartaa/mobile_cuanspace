import 'package:flutter/material.dart';
import 'package:cuan_space/services/api_service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> data = [];
  bool isLoading = true;
  int _selectedIndex = 0; // Track the selected tab
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var result = await _apiService.fetchHomeData();

    if (result['navigateToLogin'] == true) {
      Navigator.pushNamed(context, '/login');
      return;
    }

    if (result['success']) {
      setState(() {
        data = result['data'];
        isLoading = false;
      });
    } else {
      _showErrorDialog(result['message']);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error', style: TextStyle(fontFamily: 'Poppins')),
        content: Text(message, style: TextStyle(fontFamily: 'Poppins')),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK', style: TextStyle(fontFamily: 'Poppins', color: Colors.orange)),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate based on the selected index
    switch (index) {
      case 0:
        // Already on Home, no navigation needed
        break;
      case 1:
        // Navigate to Jelajahi (Explore) - Placeholder route
        Navigator.pushNamed(context, '/explore');
        break;
      case 2:
        // Navigate to Profile
        Navigator.pushNamed(context, '/profile');
        break;
      case 3:
        // Navigate to More
        Navigator.pushNamed(context, '/more');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Home', style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index]['name'], style: TextStyle(fontFamily: 'Poppins')),
                  subtitle: Text(data[index]['email'], style: TextStyle(fontFamily: 'Poppins')),
                );
              },
            ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Jelajahi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'More',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontFamily: 'Poppins'),
          backgroundColor: Colors.white,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          elevation: 0, // Remove default elevation since we have custom boxShadow
        ),
      ),
    );
  }
}