// lib/main_screen.dart
import 'package:flutter/material.dart';
import 'package:resep_app/services/auth_service.dart';
import 'package:resep_app/login_screen.dart';
import 'package:resep_app/home_screen.dart';
import 'package:resep_app/saved_recipes_screen.dart';
import 'package:resep_app/notifications_screen.dart';
import 'package:resep_app/profile_screen.dart';
import 'package:resep_app/create_recipe_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SavedRecipesScreen(),
    const NotificationsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFFAFAFA),

      // ========== DRAWER DENGAN LOGOUT ==========
      drawer: Drawer(
        child: Column(
          children: [
            // Header Drawer
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.redAccent.shade400, Colors.orangeAccent.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=200&auto=format&fit=crop&q=60'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Chef Fadly Rizky',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'chef.fadly@resepnusantara.com',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Menu Drawer
            ListTile(
              leading: const Icon(Icons.home_rounded, color: Colors.redAccent),
              title: const Text('Beranda'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bookmark_rounded, color: Colors.redAccent),
              title: const Text('Koleksi Saya'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications_rounded, color: Colors.redAccent),
              title: const Text('Notifikasi'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 2);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_rounded, color: Colors.redAccent),
              title: const Text('Profil'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 3);
              },
            ),
            const Divider(),
            // ========== LOGOUT ==========
            ListTile(
              leading: const Icon(Icons.logout_rounded, color: Colors.redAccent),
              title: const Text(
                'Keluar',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () async {
                // Tutup drawer
                Navigator.pop(context);
                // Logout
                await AuthService().logout();
                // Pindah ke LoginScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Versi 1.0.0',
                style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
              ),
            ),
          ],
        ),
      ),

      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),

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

      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 20,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_rounded, 0),
              _buildNavItem(Icons.bookmark_rounded, 1),
              const SizedBox(width: 40),
              _buildNavItem(Icons.notifications_rounded, 2),
              _buildNavItem(Icons.person_rounded, 3),
            ],
          ),
        ),
      ),
    );
  }

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