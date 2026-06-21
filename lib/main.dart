import 'package:flutter/material.dart';
import 'welcome_screen.dart'; // Memanggil halaman pertama saat aplikasi dibuka

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resep Nusantara Premium',
      debugShowCheckedModeBanner: false, // Menghilangkan pita "DEBUG" di pojok kanan atas
      theme: ThemeData(
        // Tema utama aplikasi
        primarySwatch: Colors.red,
        primaryColor: Colors.redAccent.shade400,
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        fontFamily: 'Roboto', // Pastikan font ini ada, atau ganti sesuai selera
        
        // Mempercantik efek klik (ripple) di seluruh aplikasi
        splashColor: Colors.redAccent.withOpacity(0.1),
        highlightColor: Colors.transparent,
        
        // Pengaturan tema AppBar global
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Color(0xFFFAFAFA),
          iconTheme: IconThemeData(color: Colors.black87),
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // Menetapkan WelcomeScreen sebagai halaman pertama yang muncul
      home: const WelcomeScreen(),
    );
  }
}