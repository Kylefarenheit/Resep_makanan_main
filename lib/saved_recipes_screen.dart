import 'package:flutter/material.dart';
import 'recipe_detail_screen.dart'; // Pastikan ini terhubung agar bisa di-klik

class SavedRecipesScreen extends StatefulWidget {
  const SavedRecipesScreen({super.key});

  @override
  State<SavedRecipesScreen> createState() => _SavedRecipesScreenState();
}

class _SavedRecipesScreenState extends State<SavedRecipesScreen> {
  // Data resep tersimpan yang lebih lengkap
  final List<Map<String, String>> _savedItems = [
    {
      'id': '1',
      'name': 'Soto Ayam Lamongan', 
      'chef': 'Chef Juna',
      'time': '45m',
      'rating': '4.9',
      'img': 'https://images.unsplash.com/photo-1541832676-9b763b0239ab?w=600&auto=format&fit=crop&q=60'
    },
    {
      'id': '2',
      'name': 'Rendang Sapi Padang', 
      'chef': 'Gordon Ramsay',
      'time': '3j',
      'rating': '5.0',
      'img': 'https://images.unsplash.com/photo-1601050690597-df056fb4ce78?w=600&auto=format&fit=crop&q=60'
    },
    {
      'id': '3',
      'name': 'Nasi Goreng Kampung', 
      'chef': 'Sisca Soewitomo',
      'time': '20m',
      'rating': '4.7',
      'img': 'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=600&auto=format&fit=crop&q=60'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA), // Background off-white agar card terlihat pop-out
        appBar: AppBar(
          backgroundColor: Colors.white, 
          elevation: 0,
          title: const Text(
            'Koleksi Saya', 
            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w800, fontSize: 24, letterSpacing: -0.5)
          ),
          centerTitle: false,
          bottom: TabBar(
            labelColor: Colors.redAccent.shade400, 
            unselectedLabelColor: Colors.grey.shade400, 
            indicatorColor: Colors.redAccent.shade400,
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            tabs: const [
              Tab(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.bookmark_rounded, size: 20), SizedBox(width: 8), Text('Disimpan')])),
              Tab(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.spa_rounded, size: 20), SizedBox(width: 8), Text('Menu Sehat')])),
            ],
          ),
        ),
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          children: [
            // TAB 1: DAFTAR RESEP DISIMPAN
            _savedItems.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 100),
                    physics: const BouncingScrollPhysics(),
                    itemCount: _savedItems.length,
                    itemBuilder: (context, index) {
                      final item = _savedItems[index];
                      return TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: Duration(milliseconds: 400 + (index * 100)), // Efek masuk bergantian (staggered)
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, 20 * (1 - value)),
                              child: child,
                            ),
                          );
                        },
                        child: _buildRecipeCard(item, index),
                      );
                    },
                  ),

            // TAB 2: MENU SEHAT (KOSONG ESTETIK)
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
                    child: Icon(Icons.eco_rounded, size: 80, color: Colors.green.shade400),
                  ),
                  const SizedBox(height: 25),
                  const Text('Belum Ada Menu Diet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black87)),
                  const SizedBox(height: 10),
                  Text(
                    'Koleksi ini akan otomatis terisi jika Anda menandai resep dengan kategori rendah kalori atau vegan.', 
                    textAlign: TextAlign.center, 
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 15, height: 1.5)
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade400,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mencari resep sehat...'))),
                    child: const Text('Cari Resep Sehat', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk Kartu Resep dengan fitur Swipe-to-Delete
  Widget _buildRecipeCard(Map<String, String> item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      // Fitur Geser untuk Menghapus
      child: Dismissible(
        key: Key(item['id']!),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 25),
          decoration: BoxDecoration(color: Colors.redAccent.shade400, borderRadius: BorderRadius.circular(20)),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete_sweep_rounded, color: Colors.white, size: 30),
              SizedBox(height: 4),
              Text('Hapus', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
        ),
        onDismissed: (direction) {
          final removedItem = item['name'];
          setState(() {
            _savedItems.removeAt(index);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$removedItem dihapus dari koleksi'),
              action: SnackBarAction(label: 'Batal', textColor: Colors.white, onPressed: () {
                // Logika Undo (opsional jika ingin ditambahkan nanti)
              }),
            ),
          );
        },
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetailScreen(title: item['name']!, imgUrl: item['img']!)));
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Gambar Resep
                Container(
                  height: 100, width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(image: NetworkImage(item['img']!), fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: 16),
                
                // Detail Resep
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(item['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87), maxLines: 2, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 6),
                      Text('Oleh ${item['chef']}', style: TextStyle(color: Colors.grey.shade500, fontSize: 13, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 12),
                      
                      // Row Rating & Waktu
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                                const SizedBox(width: 4),
                                Text(item['rating']!, style: TextStyle(color: Colors.amber.shade700, fontWeight: FontWeight.bold, fontSize: 12)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Row(
                            children: [
                              Icon(Icons.schedule_rounded, color: Colors.grey.shade400, size: 14),
                              const SizedBox(width: 4),
                              Text(item['time']!, style: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.bold, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget jika data kosong
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(color: Colors.red.shade50, shape: BoxShape.circle),
            child: Icon(Icons.bookmark_outline_rounded, size: 80, color: Colors.redAccent.shade200),
          ),
          const SizedBox(height: 25),
          const Text('Koleksi Kosong', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black87)),
          const SizedBox(height: 10),
          Text(
            'Simpan resep favoritmu\nagar mudah ditemukan nanti.', 
            textAlign: TextAlign.center, 
            style: TextStyle(color: Colors.grey.shade500, fontSize: 15, height: 1.5)
          ),
        ],
      ),
    );
  }
}