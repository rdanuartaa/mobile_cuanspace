import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome.dart';
import 'screens/register.dart';
import 'screens/login.dart';
import 'screens/home.dart';
import 'screens/forgotpassword.dart';
import 'screens/resetpassword.dart'; // Tambahkan impor ini

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Suan Space',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Poppins'),
          headlineSmall: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/welcome': (context) => Welcome(),
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/home': (context) => Home(),
        '/forgot-password': (context) => const ForgotPassword(),
        '/reset-password': (context) => const ResetPassword(), // Tambahkan rute ini
      },
    );
  }
}