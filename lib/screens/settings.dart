import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/services/theme_provider.dart'; // File untuk mengelola tema

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedLanguage = 'Indonesia';
  bool notificationsEnabled = true;
  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  // Fungsi untuk menampilkan notifikasi melayang
  void showFloatingNotification(String message) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        left: 16,
        right: 16,
        child: Material(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    // Hapus notifikasi setelah 3 detik
    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  Future<void> loadSettings() async {
    try {
      setState(() {
        isLoading = true;
      });
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        selectedLanguage = prefs.getString('language') ?? 'Indonesia';
        notificationsEnabled = prefs.getBool('notifications') ?? true;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Terjadi kesalahan: $e';
      });
      showFloatingNotification('Terjadi kesalahan: $e');
    }
  }

  Future<void> saveSettings() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('language', selectedLanguage);
      await prefs.setBool('notifications', notificationsEnabled);
      setState(() {
        isLoading = false;
      });
      showFloatingNotification('Pengaturan berhasil disimpan');
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Terjadi kesalahan: $e';
      });
      showFloatingNotification('Terjadi kesalahan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context); // Akses ThemeProvider

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Pengaturan',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary))
          : Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.language, color: Theme.of(context).colorScheme.primary),
                    title: Text(
                      'Bahasa',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    trailing: DropdownButton<String>(
                      value: selectedLanguage,
                      dropdownColor: Theme.of(context).colorScheme.surface,
                      style: Theme.of(context).textTheme.bodyMedium,
                      items: ['Indonesia', 'English'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedLanguage = value!;
                        });
                        saveSettings();
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.notifications, color: Theme.of(context).colorScheme.primary),
                    title: Text(
                      'Notifikasi',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    trailing: Switch(
                      value: notificationsEnabled,
                      activeColor: Theme.of(context).colorScheme.primary,
                      onChanged: (value) {
                        setState(() {
                          notificationsEnabled = value;
                        });
                        saveSettings();
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.dark_mode, color: Theme.of(context).colorScheme.primary),
                    title: Text(
                      'Mode Gelap',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    trailing: Switch(
                      value: themeProvider.isDarkMode,
                      activeColor: Theme.of(context).colorScheme.primary,
                      onChanged: (value) {
                        themeProvider.toggleTheme(value);
                        showFloatingNotification(value ? 'Mode gelap diaktifkan' : 'Mode terang diaktifkan');
                      },
                    ),
                  ),
                  if (errorMessage.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        errorMessage,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.red,
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}