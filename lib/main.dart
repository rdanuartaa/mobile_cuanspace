import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/register_page.dart';
import 'screens/dashboard_page.dart';
import 'screens/home_page.dart';
import 'screens/notification_page.dart';
import 'screens/orders_page.dart';
import 'screens/user_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter SQLite Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/dashboard': (context) => DashboardPage(username: '',),
        '/home': (context) => HomePage(),
        '/notification': (context) => NotificationPage(),
        '/order': (context) => OrdersPage(),
        '/user': (context) => UserPage(username: '',),
      },
    );
  }
}
