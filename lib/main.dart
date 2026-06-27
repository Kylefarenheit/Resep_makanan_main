// lib/main.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:resep_app/services/auth_service.dart';
import 'package:resep_app/login_screen.dart';
import 'package:resep_app/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resep Nusantara Premium',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.redAccent.shade400,
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        fontFamily: 'Roboto',
        splashColor: Colors.redAccent.withOpacity(0.1),
        highlightColor: Colors.transparent,
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
      home: FutureBuilder<bool>(
        future: AuthService().isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.data == true) {
            return MainScreen(); // HAPUS const
          } else {
            return LoginScreen(); // HAPUS const
          }
        },
      ),
    );
  }
}
