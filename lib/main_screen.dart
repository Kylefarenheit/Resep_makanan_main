import 'package:flutter/material.dart';

// Pastikan semua file ini sudah ada di folder 'lib' Anda
import 'home_screen.dart';
import 'saved_recipes_screen.dart';
import 'notifications_screen.dart'; // Sesuaikan nama file jika berbeda
import 'profile_screen.dart';
import 'create_recipe_screen.dart'; 

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Daftar halaman yang akan ditampilkan di dalam kerangka Main Screen.
  // 💡 CATATAN: Jika tulisan nama Screen di bawah ini bergaris merah, 
  // hapus kata 'const' di depannya.
  final List<Widget> _screens = [
    const HomeScreen(),
    const SavedRecipesScreen(),
    const NotificationsScreen(), // Pastikan nama class-nya sesuai dengan file Anda
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody WAJIB true agar konten background tembus ke bawah Bottom Nav
      extendBody: true,
      backgroundColor: const Color(0xFFFAFAFA),
      
      // IndexedStack menahan state halaman agar tidak reload saat berpindah tab
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),

      // 1. TOMBOL FLOATING TENGAH (TAMBAH RESEP)
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 65,
        width: 65,
        margin: const EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Colors.redAccent.shade400, Colors.orangeAccent.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.redAccent.withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          highlightElevation: 0,
          onPressed: () {
            // Animasi transisi meluncur dari bawah ke atas saat membuka form tambah resep
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, anim, secAnim) => const CreateRecipeScreen(),
                transitionsBuilder: (context, anim, secAnim, child) {
                  return SlideTransition(
                    position: anim.drive(
                      Tween(begin: const Offset(0.0, 1.0), end: Offset.zero)
                          .chain(CurveTween(curve: Curves.easeOutQuart)),
                    ),
                    child: child,
                  );
                },
              ),
            );
          },
          child: const Icon(Icons.add_rounded, color: Colors.white, size: 36),
        ),
      ),

      // 2. BOTTOM NAVIGATION BAR
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 20,
        shape: const CircularNotchedRectangle(), // Membuat efek melengkung (notch)
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Tab Kiri
              _buildNavItem(Icons.home_rounded, 0),
              _buildNavItem(Icons.bookmark_rounded, 1),
              
              const SizedBox(width: 40), // Jarak kosong untuk tempat Floating Button
              
              // Tab Kanan
              _buildNavItem(Icons.notifications_rounded, 2),
              _buildNavItem(Icons.person_rounded, 3),
            ],
          ),
        ),
      ),
    );
  }

  // Widget Bantuan untuk Membuat Ikon Navigasi yang Interaktif
  Widget _buildNavItem(IconData icon, int index) {
    bool isSelected = _currentIndex == index;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedScale(
            scale: isSelected ? 1.2 : 1.0,
            duration: const Duration(milliseconds: 250),
            child: Icon(
              icon,
              color: isSelected ? Colors.redAccent.shade400 : Colors.grey.shade400,
              size: 26,
            ),
          ),
          const SizedBox(height: 4),
          // Titik kecil indikator di bawah ikon yang aktif
          AnimatedOpacity(
            opacity: isSelected ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 250),
            child: Container(
              height: 5,
              width: 5,
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
            ),
          )
        ],
      ),
    );
  }
}