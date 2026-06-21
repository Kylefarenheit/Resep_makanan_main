import 'package:flutter/material.dart';
import 'main_screen.dart'; // Pastikan ini terhubung dengan main_screen.dart Anda

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Kontrol untuk menyembunyikan/menampilkan password
  bool _isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    // Mendapatkan tinggi layar untuk proporsi gambar yang pas
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER: Gambar Estetik + Efek Gradien
            Stack(
              children: [
                Container(
                  height: screenHeight * 0.45,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=800&auto=format&fit=crop&q=80'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Gradien untuk menyamarkan batas bawah gambar dengan background putih
                Container(
                  height: screenHeight * 0.45,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.2),
                        Colors.white,
                      ],
                      stops: const [0.0, 0.6, 1.0],
                    ),
                  ),
                ),
                // Teks Sapaan di atas gambar
                Positioned(
                  bottom: 40,
                  left: 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Resep\nNusantara.',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          height: 1.1,
                          letterSpacing: -1.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Eksplorasi rasa tanpa batas',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),

            // FORM AREA: Menggunakan Animasi Tween (Slide up & Fade in)
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, 50 * (1 - value)), // Meluncur dari bawah 50px
                  child: Opacity(
                    opacity: value, // Transparansi memudar masuk
                    child: child,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    // INPUT EMAIL
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.red.shade100.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
                        ],
                      ),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Email Address',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          prefixIcon: const Icon(Icons.alternate_email, color: Colors.redAccent),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // INPUT PASSWORD BERFUNGSI (Bisa diintip)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.red.shade100.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
                        ],
                      ),
                      child: TextField(
                        obscureText: _isPasswordHidden,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          prefixIcon: const Icon(Icons.lock_outline_rounded, color: Colors.redAccent),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 20),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordHidden ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                              color: Colors.grey.shade400,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordHidden = !_isPasswordHidden;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // LUPA SANDI
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Menuju halaman pemulihan sandi...'))),
                        child: Text(
                          'Lupa Sandi?',
                          style: TextStyle(color: Colors.redAccent.shade400, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),

                    // TOMBOL LOGIN UTAMA DENGAN GRADIENT
                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [Colors.redAccent.shade400, Colors.orangeAccent.shade400],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(color: Colors.redAccent.withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 8)),
                        ],
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () {
                          // Navigasi yang anggun ke Main Screen
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => const MainScreen(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return FadeTransition(opacity: animation, child: child);
                              },
                            ),
                          );
                        },
                        child: const Text('Masuk ke Dapur', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1)),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // SOCIAL LOGIN DIVIDER
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text('Atau masuk dengan', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                        ),
                        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
                      ],
                    ),
                    const SizedBox(height: 25),

                    // SOCIAL BUTTONS ESTETIK
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialButton(Icons.g_mobiledata_rounded, Colors.red, context),
                        const SizedBox(width: 20),
                        _buildSocialButton(Icons.facebook_rounded, Colors.blue.shade700, context),
                        const SizedBox(width: 20),
                        _buildSocialButton(Icons.apple, Colors.black, context),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // REGISTER TEXT
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Koki baru di sini? ', style: TextStyle(color: Colors.grey.shade600, fontSize: 15)),
                        GestureDetector(
                          onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Membuka halaman Pendaftaran...'))),
                          child: Text(
                            'Daftar Sekarang',
                            style: TextStyle(color: Colors.redAccent.shade400, fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget custom untuk tombol sosial media
  Widget _buildSocialButton(IconData icon, Color color, BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Integrasi pihak ketiga segera hadir!'))),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200, width: 2),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade100, blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Icon(icon, color: color, size: 32),
      ),
    );
  }
}