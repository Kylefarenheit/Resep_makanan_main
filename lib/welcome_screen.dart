import 'package:flutter/material.dart';
import 'login_screen.dart'; // 🟢 WAJIB ADA: Import file login Anda di sini

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=800&auto=format&fit=crop&q=80'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient Overlay biar teks terbaca
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.9),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
          // Konten Teks & Tombol
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.restaurant_menu_rounded, color: Colors.orangeAccent, size: 16),
                        SizedBox(width: 8),
                        Text(
                          'Koleksi Resep Terbaik',
                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Masak Lezat\nSetiap Hari.',
                    style: TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.w900, height: 1.15, letterSpacing: -1.5),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Temukan ribuan resep nusantara pilihan dari chef profesional langsung di genggaman tanganmu.',
                    style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 40),
                  
                  // ==========================================
                  // TOMBOL MASUK KE LOGIN SCREEN
                  // ==========================================
                  Container(
                    width: double.infinity,
                    height: 62,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: LinearGradient(
                        colors: [Colors.redAccent.shade400, Colors.orangeAccent.shade400],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(color: Colors.redAccent.withOpacity(0.35), blurRadius: 20, offset: const Offset(0, 10)),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                      ),
                      onPressed: () {
                        // 🟢 INI KODE NAVIGASI KE HALAMAN LOGIN
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(), // Memanggil LoginScreen
                          ),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Masuk / Mulai Memasak', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                          SizedBox(width: 12),
                          Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 22),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
