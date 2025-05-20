import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends InheritedWidget {
  final bool isDarkMode;
  final void Function(bool, [Function(String)?]) toggleTheme;

  ThemeProvider({
    required this.isDarkMode,
    required this.toggleTheme,
    required Widget child,
  }) : super(child: child);

  static ThemeProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>()!;
  }

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) {
    return isDarkMode != oldWidget.isDarkMode;
  }
}

class ThemeWrapper extends StatefulWidget {
  final Widget child;

  ThemeWrapper({required this.child});

  @override
  _ThemeWrapperState createState() => _ThemeWrapperState();
}

class _ThemeWrapperState extends State<ThemeWrapper> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      });
    } catch (e) {
      // Log error atau tampilkan notifikasi jika diperlukan
      print('Error loading theme: $e');
    }
  }

  Future<void> _toggleTheme(bool value, [Function(String)? onError]) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _isDarkMode = value;
      });
      await prefs.setBool('isDarkMode', value);
    } catch (e) {
      onError?.call('Gagal mengubah tema: $e');
      print('Error saving theme: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      isDarkMode: _isDarkMode,
      toggleTheme: _toggleTheme,
      child: widget.child,
    );
  }
}