import 'package:flutter/material.dart';
import 'package:resep_app/search_screen.dart';
import 'recipe_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // State untuk Mode Hemat Daya
  bool _isEcoMode = false;
  
  // State untuk Kategori yang dipilih
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ['Semua', '🔥 Pedas', '🥗 Sehat', '🍜 Kuah', '🍰 Manis', '🍗 Daging'];

  // Data Banner Promo (Carousel)
  final List<Map<String, dynamic>> _bannerItems = [
    {
      'title': 'Promo Spesial Akhir Tahun!',
      'subtitle': 'Diskon 50% untuk semua kelas memasak',
      'img': 'https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=800&auto=format&fit=crop&q=80',
      'color': Colors.redAccent,
    },
    {
      'title': 'Resep Baru Setiap Hari',
      'subtitle': 'Eksplorasi 100+ resep nusantara',
      'img': 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800&auto=format&fit=crop&q=80',
      'color': Colors.orangeAccent,
    },
    {
      'title': 'Challenge Masak #30Hari',
      'subtitle': 'Ikuti tantangan dan menangkan hadiah!',
      'img': 'https://images.unsplash.com/photo-1547592180-85f173990554?w=800&auto=format&fit=crop&q=80',
      'color': Colors.purpleAccent,
    },
  ];

  // Data Resep Viral dengan kategori
  final List<Map<String, String>> _viralRecipes = [
    {
      'title': 'Pizza Keju Lumer',
      'chef': 'Chef Renata',
      'rating': '4.9',
      'time': '25m',
      'img': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=600&auto=format&fit=crop&q=60',
      'category': 'Manis',
    },
    {
      'title': 'Salmon Salad Premium',
      'chef': 'Dr. Reisa',
      'rating': '4.8',
      'time': '15m',
      'img': 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=600&auto=format&fit=crop&q=60',
      'category': 'Sehat',
    },
    {
      'title': 'Sate Ayam Madura Asli',
      'chef': 'Cak Umar',
      'rating': '4.9',
      'time': '30m',
      'img': 'https://images.unsplash.com/photo-1529042410759-befb1204b468?w=600&auto=format&fit=crop&q=60',
      'category': 'Daging',
    },
    {
      'title': 'Rendang Sapi Padang',
      'chef': 'Chef Juna',
      'rating': '4.9',
      'time': '3j',
      'img': 'https://images.unsplash.com/photo-1601050690597-df056fb4ce78?w=600&auto=format&fit=crop&q=60',
      'category': 'Daging',
    },
    {
      'title': 'Mie Ayam Jamur Spesial',
      'chef': 'Chef Andika',
      'rating': '4.7',
      'time': '35m',
      'img': 'https://images.unsplash.com/photo-1552611052-33e04de081de?w=600&auto=format&fit=crop&q=60',
      'category': 'Kuah',
    },
    {
      'title': 'Es Campur Segar',
      'chef': 'Chef Maya',
      'rating': '4.6',
      'time': '20m',
      'img': 'https://images.unsplash.com/photo-1547592180-85f173990554?w=600&auto=format&fit=crop&q=60',
      'category': 'Manis',
    },
  ];

  // State untuk Pull to Refresh
  Future<void> _onRefresh() async {
    // Simulasi refresh data
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      // Reset kategori ke 'Semua'
      _selectedCategoryIndex = 0;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🔄 Resep berhasil diperbarui!'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 1),
      ),
    );
  }

  // Filter resep berdasarkan kategori
  List<Map<String, String>> get _filteredRecipes {
    if (_selectedCategoryIndex == 0) {
      return _viralRecipes; // Semua
    }
    
    final selectedCategory = _categories[_selectedCategoryIndex].replaceAll('🔥 ', '').replaceAll('🥗 ', '').replaceAll('🍜 ', '').replaceAll('🍰 ', '').replaceAll('🍗 ', '');
    return _viralRecipes.where((recipe) {
      return recipe['category']!.toLowerCase() == selectedCategory.toLowerCase();
    }).toList();
  }

  // State untuk Carousel
  int _currentBannerIndex = 0;
  final PageController _bannerController = PageController();

  @override
  void initState() {
    super.initState();
    // Auto-slide banner setiap 4 detik
    Future.delayed(const Duration(seconds: 4), _autoSlideBanner);
  }

  void _autoSlideBanner() {
    if (mounted) {
      setState(() {
        _currentBannerIndex = (_currentBannerIndex + 1) % _bannerItems.length;
        _bannerController.animateToPage(
          _currentBannerIndex,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      });
      // Schedule next slide
      Future.delayed(const Duration(seconds: 4), _autoSlideBanner);
    }
  }

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isEcoMode ? Colors.grey.shade100 : const Color(0xFFFAFAFA),
      
      // DRAWER
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.redAccent.shade400, Colors.orangeAccent.shade400]),
              ),
              accountName: const Text('Chef Fadly Rizky', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              accountEmail: const Text('chef.fadly@resepnusantara.com'),
              currentAccountPicture: Container(
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                child: const CircleAvatar(backgroundImage: NetworkImage('https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=200&auto=format&fit=crop&q=60')),
              ),
            ),
            SwitchListTile(
              title: const Text('Mode Hemat Daya', style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: const Text('Kurangi animasi & kontras', style: TextStyle(fontSize: 12)),
              secondary: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle), child: const Icon(Icons.eco_rounded, color: Colors.green)),
              activeColor: Colors.redAccent,
              value: _isEcoMode,
              onChanged: (bool value) {
                setState(() { _isEcoMode = value; });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_isEcoMode ? 'Mode hemat daya diaktifkan 🍃' : 'Mode standar diaktifkan ⚡', style: const TextStyle(fontWeight: FontWeight.bold))));
              },
            ),
            const Divider(),
            ListTile(
              leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade200, shape: BoxShape.circle), child: const Icon(Icons.settings_rounded, color: Colors.black87)), 
              title: const Text('Pengaturan Akun', style: TextStyle(fontWeight: FontWeight.w600)), 
              onTap: () { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Membuka Pengaturan...'))); }
            ),
          ],
        ),
      ),

      // APP BAR
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: Colors.black87, size: 28), 
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lokasi Dapur', style: TextStyle(color: Colors.grey.shade500, fontSize: 12, fontWeight: FontWeight.w600)),
            Row(
              children: const [
                Icon(Icons.location_on_rounded, color: Colors.redAccent, size: 16),
                SizedBox(width: 4),
                Text('Ngawi, Indonesia', style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold)),
                Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black87, size: 18),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              backgroundImage: const NetworkImage('https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=200&auto=format&fit=crop&q=60'),
            ),
          )
        ],
      ),

      // BODY DENGAN PULL TO REFRESH
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: Colors.redAccent,
        backgroundColor: Colors.white,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutQuart,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 30 * (1 - value)),
                child: child,
              ),
            );
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                
                // GREETING TEXT
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text.rich(
                    TextSpan(
                      text: 'Mau masak apa\n',
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w400, color: Colors.black87, height: 1.2),
                      children: [
                        TextSpan(text: 'hari ini, Chef?', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.redAccent.shade400)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // SEARCH BAR
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Navigasi ke halaman search
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SearchScreen()),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 15, offset: const Offset(0, 8))],
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.search_rounded, color: Colors.grey),
                                const SizedBox(width: 12),
                                Text(
                                  'Cari resep atau bahan...',
                                  style: TextStyle(color: Colors.grey.shade400, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Menu Filter dibuka'))),
                        child: Container(
                          height: 55, width: 55,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [Colors.redAccent.shade400, Colors.orangeAccent.shade400], begin: Alignment.topLeft, end: Alignment.bottomRight),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [BoxShadow(color: Colors.redAccent.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))],
                          ),
                          child: const Icon(Icons.tune_rounded, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // 🎠 CAROUSEL / BANNER PROMO
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Promo Spesial 🎉',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15, offset: const Offset(0, 8)),
                          ],
                        ),
                        child: Stack(
                          children: [
                            // Carousel PageView
                            PageView.builder(
                              controller: _bannerController,
                              onPageChanged: (index) {
                                setState(() {
                                  _currentBannerIndex = index;
                                });
                              },
                              itemCount: _bannerItems.length,
                              itemBuilder: (context, index) {
                                final banner = _bannerItems[index];
                                return GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('${banner['title']} - Klik untuk detail!')),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: NetworkImage(banner['img']!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: LinearGradient(
                                          colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            banner['title']!,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            banner['subtitle']!,
                                            style: TextStyle(
                                              color: Colors.white.withOpacity(0.8),
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            // Indicator dots
                            Positioned(
                              bottom: 10,
                              right: 16,
                              child: Row(
                                children: List.generate(
                                  _bannerItems.length,
                                  (index) => Container(
                                    margin: const EdgeInsets.only(left: 6),
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _currentBannerIndex == index
                                          ? Colors.white
                                          : Colors.white.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // KATEGORI (INTERAKTIF + FILTER)
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      bool isSelected = _selectedCategoryIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() { 
                            _selectedCategoryIndex = index; 
                          });
                          // Feedback haptic (opsional)
                          ScaffoldMessenger.of(context).clearSnackBars();
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.redAccent : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: isSelected ? null : Border.all(color: Colors.grey.shade300),
                            boxShadow: isSelected ? [BoxShadow(color: Colors.redAccent.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))] : [],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            _categories[index],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),

                // HERO CARD (REKOMENDASI HARI INI)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Sedang Viral 🔥',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategoryIndex = 0;
                          });
                        },
                        child: Text(
                          'Lihat Semua',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.redAccent.shade400),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                // RESEP VIRAL (DENGAN FILTER)
                _filteredRecipes.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(Icons.search_off_rounded, size: 60, color: Colors.grey.shade400),
                              const SizedBox(height: 12),
                              Text(
                                'Tidak ada resep untuk kategori ini',
                                style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(left: 20),
                          itemCount: _filteredRecipes.length,
                          itemBuilder: (context, index) {
                            final item = _filteredRecipes[index];
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context) => RecipeDetailScreen(
                                    title: item['title']!,
                                    imgUrl: item['img']!,
                                    ingredients: const [],
                                    steps: const [],
                                  ),
                                ),
                              ),
                              child: Container(
                                width: 180,
                                margin: const EdgeInsets.only(right: 16, bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 10, offset: const Offset(0, 6))],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Card Image
                                    Container(
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                        image: DecorationImage(
                                          image: NetworkImage(item['img']!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      alignment: Alignment.topRight,
                                      padding: const EdgeInsets.all(8),
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), shape: BoxShape.circle),
                                        child: const Icon(Icons.favorite_border_rounded, color: Colors.redAccent, size: 18),
                                      ),
                                    ),
                                    // Card Content
                                    Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['title']!,
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Oleh ${item['chef']}',
                                            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(children: [
                                                const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                                                Text(' ${item['rating']}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                              ]),
                                              Row(children: [
                                                const Icon(Icons.schedule_rounded, color: Colors.grey, size: 14),
                                                Text(' ${item['time']}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                                              ]),
                                            ],
                                          ),
                                          // Badge Kategori (menampilkan kategori resep)
                                          Container(
                                            margin: const EdgeInsets.only(top: 6),
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: Colors.red.shade50,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              item['category'] ?? '',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.redAccent.shade400,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}