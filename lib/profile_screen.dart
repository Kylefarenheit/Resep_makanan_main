import 'package:flutter/material.dart';
import 'recipe_detail_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = 'Chef Fadly Rizky';
  String _bio = 'Eksplorator Kuliner Tradisional & Modern 🍳';

  // Data resep dengan format lengkap yang sesuai dengan RecipeDetailScreen
  final List<Map<String, dynamic>> _myRecipes = [
    {
      'title': 'Ayam Bakar Madu',
      'img': 'https://images.unsplash.com/photo-1532550907401-a500c9a57435?w=500&auto=format&fit=crop&q=60',
      'ingredients': [
        '1 ekor ayam (potong 4 bagian)',
        '3 sdm madu murni',
        '2 siung bawang putih (haluskan)',
        '1 sdm kecap manis',
        '1 sdt garam',
        '1 sdt merica bubuk'
      ],
      'steps': [
        'Bersihkan ayam dan lumuri dengan air jeruk nipis selama 15 menit',
        'Campurkan madu, bawang putih, kecap, garam, dan merica sebagai bumbu oles',
        'Lumuri ayam dengan bumbu oles, diamkan minimal 30 menit agar meresap',
        'Bakar ayam di atas grill sambil sesekali diolesi bumbu hingga matang merata',
        'Sajikan dengan sambal dan lalapan segar'
      ],
      'time': '45 Menit',
      'difficulty': 'Mudah',
      'calories': '350',
      'protein': '25g',
      'carbs': '15g',
      'fat': '12g',
      'rating': '4.8'
    },
    {
      'title': 'Sop Buntut Sapi',
      'img': 'https://images.unsplash.com/photo-1547592180-85f173990554?w=500&auto=format&fit=crop&q=60',
      'ingredients': [
        '500 gr buntut sapi',
        '2 wortel (potong bulat)',
        '2 kentang (potong dadu)',
        '2 batang daun bawang',
        '2 batang seledri',
        '1 sdt garam',
        '1/2 sdt merica'
      ],
      'steps': [
        'Rebus buntut sapi hingga empuk (kurang lebih 2 jam)',
        'Masukkan wortel dan kentang, masak hingga matang',
        'Tambahkan garam dan merica sesuai selera',
        'Terakhir masukkan daun bawang dan seledri',
        'Sajikan dengan taburan bawang goreng'
      ],
      'time': '2 Jam',
      'difficulty': 'Sedang',
      'calories': '420',
      'protein': '30g',
      'carbs': '20g',
      'fat': '18g',
      'rating': '4.9'
    },
    {
      'title': 'Martabak Manis Keju',
      'img': 'https://images.unsplash.com/photo-1551024601-bec78aea704b?w=500&auto=format&fit=crop&q=60',
      'ingredients': [
        '250 gr tepung terigu',
        '2 butir telur',
        '100 gr gula pasir',
        '1 sdt ragi instan',
        '200 ml susu cair',
        '50 gr margarin leleh',
        'Keju parut secukupnya',
        'Kental manis secukupnya'
      ],
      'steps': [
        'Campur tepung, gula, ragi, telur, dan susu. Aduk hingga rata',
        'Diamkan adonan selama 1 jam hingga mengembang',
        'Tuang adonan ke wajan teflon, masak dengan api kecil',
        'Taburi keju dan kental manis di atas martabak',
        'Lipat martabak dan sajikan hangat'
      ],
      'time': '1.5 Jam',
      'difficulty': 'Sedang',
      'calories': '380',
      'protein': '12g',
      'carbs': '45g',
      'fat': '15g',
      'rating': '4.7'
    },
    {
      'title': 'Gado-Gado Betawi',
      'img': 'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=500&auto=format&fit=crop&q=60',
      'ingredients': [
        '100 gr kacang panjang',
        '100 gr tauge',
        '2 buah kentang rebus',
        '2 butir telur rebus',
        '1 bungkus lontong',
        '100 gr kerupuk',
        'Bumbu kacang: kacang tanah, cabai, bawang putih, kencur'
      ],
      'steps': [
        'Rebus sayuran secara terpisah agar tidak terlalu matang',
        'Haluskan bumbu kacang dengan blender atau ulekan',
        'Tambahkan air matang pada bumbu kacang hingga kekentalan yang diinginkan',
        'Tata sayuran, telur, dan lontong di atas piring',
        'Siram dengan bumbu kacang dan taburi kerupuk'
      ],
      'time': '40 Menit',
      'difficulty': 'Mudah',
      'calories': '310',
      'protein': '18g',
      'carbs': '35g',
      'fat': '14g',
      'rating': '4.6'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // HEADER AREA
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.redAccent.shade400, Colors.orangeAccent.shade400],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
                  ),
                ),
                // Tombol Pengaturan
                Positioned(
                  top: 50,
                  right: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: IconButton(
                      icon: const Icon(Icons.settings_rounded, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SettingsScreen()),
                        );
                      },
                    ),
                  ),
                ),
                // Foto Profil
                Positioned(
                  top: 110,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 55,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=400&auto=format&fit=crop&q=60',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),

            // NAMA & BIO
            Text(
              _name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Colors.black87,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              _bio,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 15),

            // Tombol Edit Profil
            ElevatedButton.icon(
              onPressed: _showEditProfileDialog,
              icon: const Icon(Icons.edit),
              label: const Text('Edit Profil'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 25),

            // STATISTIK CARD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('${_myRecipes.length}', 'Resep'),
                    Container(height: 30, width: 1, color: Colors.grey.shade200),
                    _buildStatItem('14.2k', 'Pengikut'),
                    Container(height: 30, width: 1, color: Colors.grey.shade200),
                    _buildStatItem('98k', 'Suka'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 35),

            // JUDUL GALERI
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Resep Saya',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Icon(Icons.grid_view_rounded, color: Colors.redAccent, size: 20),
                ],
              ),
            ),
            const SizedBox(height: 15),

            // GRID GALERI RESEP
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _myRecipes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final recipe = _myRecipes[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailScreen(
                            title: recipe['title']!,
                            imgUrl: recipe['img']!,
                            ingredients: List<String>.from(recipe['ingredients']!),
                            steps: List<String>.from(recipe['steps']!),
                            rating: recipe['rating']?.toString() ?? '4.8',
                            time: recipe['time'] ?? '30 Menit',
                            difficulty: recipe['difficulty'] ?? 'Mudah',
                            calories: recipe['calories'] ?? '350',
                            protein: recipe['protein'] ?? '15g',
                            carbs: recipe['carbs'] ?? '25g',
                            fat: recipe['fat'] ?? '10g',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade100,
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                image: DecorationImage(
                                  image: NetworkImage(recipe['img']!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              recipe['title']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _showEditProfileDialog() {
    final nameController = TextEditingController(text: _name);
    final bioController = TextEditingController(text: _bio);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Edit Profil'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: bioController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Bio',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Batal'),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text('Simpan'),
              onPressed: () {
                setState(() {
                  _name = nameController.text;
                  _bio = bioController.text;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profil berhasil diperbarui'),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}