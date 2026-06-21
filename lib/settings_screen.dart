import 'package:flutter/material.dart';
import 'login_screen.dart'; // Untuk fitur logout

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Pengaturan', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text('Akun Saya', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.redAccent)),
          const SizedBox(height: 10),
          _buildSettingItem(Icons.person_outline_rounded, 'Edit Profil'),
          _buildSettingItem(Icons.lock_outline_rounded, 'Ubah Password'),
          
          const SizedBox(height: 30),
          const Text('Preferensi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.redAccent)),
          const SizedBox(height: 10),
          // Switch Notifikasi
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle),
              child: const Icon(Icons.notifications_none_rounded, color: Colors.black87),
            ),
            title: const Text('Notifikasi Push', style: TextStyle(fontWeight: FontWeight.w600)),
            trailing: Switch(
              value: _notifEnabled,
              activeColor: Colors.redAccent,
              onChanged: (val) => setState(() => _notifEnabled = val),
            ),
          ),
          _buildSettingItem(Icons.language_rounded, 'Bahasa (Indonesia)'),
          
          const SizedBox(height: 30),
          const Text('Lainnya', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.redAccent)),
          const SizedBox(height: 10),
          _buildSettingItem(Icons.help_outline_rounded, 'Pusat Bantuan'),
          _buildSettingItem(Icons.info_outline_rounded, 'Tentang Aplikasi'),
          
          const SizedBox(height: 40),
          // Tombol Keluar (Logout)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade50,
              foregroundColor: Colors.redAccent,
              elevation: 0,
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false, // Menghapus semua history tumpukan layar
              );
            },
            child: const Text('Keluar Akun', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  // Widget Bantuan
  Widget _buildSettingItem(IconData icon, String title) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.black87),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
      onTap: () {},
    );
  }
}