import 'package:flutter/material.dart';
import 'package:resep_app/search_screen.dart';
import 'recipe_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isEcoMode = false;
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ['Semua', '🔥 Pedas', '🥗 Sehat', '🍜 Kuah', '🍰 Manis', '🍗 Daging'];

  // Data viral dengan ingredients & steps (sudah diperbaiki)
  final List<Map<String, dynamic>> _viralRecipes = [
    {
      'title': 'Pizza Keju Lumer',
      'chef': 'Chef Renata',
      'rating': '4.9',
      'time': '25m',
      'img':
          'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=600&auto=format&fit=crop&q=60',
      'ingredients': ['Tepung terigu', 'Keju mozzarella', 'Saus tomat', 'Pepperoni', 'Jamur'],
      'steps': ['Panaskan oven 200°C', 'Giling adonan pizza', 'Oles saus dan topping', 'Panggang 15 menit']
    },
    {
      'title': 'Salmon Salad Premium',
      'chef': 'Dr. Reisa',
      'rating': '4.8',
      'time': '15m',
      'img':
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=600&auto=format&fit=crop&q=60',
      'ingredients': ['Salmon fillet', 'Selada', 'Alpukat', 'Tomat cherry', 'Lemon dressing'],
      'steps': ['Cuci sayuran', 'Potong salmon tipis', 'Susun di piring', 'Siram dressing']
    },
    {
      'title': 'Sate Ayam Madura Asli',
      'chef': 'Cak Umar',
      'rating': '4.9',
      'time': '30m',
      'img':
          'https://images.unsplash.com/photo-1529042410759-befb1204b468?w=600&auto=format&fit=crop&q=60',
      'ingredients': ['Dada ayam', 'Kecap manis', 'Bumbu kacang', 'Jeruk limau', 'Serai'],
      'steps': ['Potong ayam kecil', 'Tusuk dengan lidi', 'Bakar sambil oles bumbu', 'Sajikan dengan sambal']
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isEcoMode ? Colors.grey.shade100 : const Color(0xFFFAFAFA),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.redAccent.shade400, Colors.orangeAccent.shade400]),
              ),
              accountName: const Text('Chef Fadly Rizky',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              accountEmail: const Text('chef.fadly@resepnusantara.com'),
              currentAccountPicture: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2)),
                child: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=200&auto=format&fit=crop&q=60')),
              ),
            ),
            SwitchListTile(
              title: const Text('Mode Hemat Daya', style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: const Text('Kurangi animasi & kontras', style: TextStyle(fontSize: 12)),
              secondary: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.green.shade50, shape: BoxShape.circle),
                  child: const Icon(Icons.eco_rounded, color: Colors.green)),
              activeColor: Colors.redAccent,
              value: _isEcoMode,
              onChanged: (bool value) {
                setState(() {
                  _isEcoMode = value;
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(_isEcoMode
                        ? 'Mode hemat daya diaktifkan 🍃'
                        : 'Mode standar diaktifkan ⚡',
                        style: const TextStyle(fontWeight: FontWeight.bold))));
              },
            ),
            const Divider(),
            ListTile(
              leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.grey.shade200, shape: BoxShape.circle),
                  child: const Icon(Icons.settings_rounded, color: Colors.black87)),
              title: const Text('Pengaturan Akun', style: TextStyle(fontWeight: FontWeight.w600)),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Membuka Pengaturan...')));
              },
            ),
          ],
        ),
      ),
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
            Text('Lokasi Dapur',
                style: TextStyle(
                    color: Colors.grey.shade500, fontSize: 12, fontWeight: FontWeight.w600)),
            Row(
              children: const [
                Icon(Icons.location_on_rounded, color: Colors.redAccent, size: 16),
                SizedBox(width: 4),
                Text('Ngawi, Indonesia',
                    style:
                        TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold)),
                Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black87, size: 18),
              ],
            ),
          ],
        ),
        actions: [
          // ==================== PERBAIKAN: Tombol Pencarian (tanpa const) ====================
          IconButton(
            icon: const Icon(Icons.search_rounded, color: Colors.black87, size: 28),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(), // <-- const dihilangkan!
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              backgroundImage: const NetworkImage(
                  'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=200&auto=format&fit=crop&q=60'),
            ),
          )
        ],
      ),
      body: TweenAnimationBuilder<double>(
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
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text.rich(
                  TextSpan(
                    text: 'Mau masak apa\n',
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                        height: 1.2),
                    children: [
                      TextSpan(
                          text: 'hari ini, Chef?',
                          style: TextStyle(
                              fontWeight: FontWeight.w900, color: Colors.redAccent.shade400)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 15,
                                offset: const Offset(0, 8))
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Cari resep atau bahan...',
                            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
                            icon: const Icon(Icons.search_rounded, color: Colors.grey),
                          ),
                          onTap: () {
                            // Bisa juga langsung navigasi ke SearchScreen saat field diklik
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchScreen(), // tanpa const
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () => ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text('Menu Filter dibuka'))),
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.redAccent.shade400, Colors.orangeAccent.shade400],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.redAccent.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 5))
                          ],
                        ),
                        child: const Icon(Icons.tune_rounded, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
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
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.redAccent : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: isSelected ? null : Border.all(color: Colors.grey.shade300),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                      color: Colors.redAccent.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4))
                                ]
                              : [],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _categories[index],
                          style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Rekomendasi Hari Ini',
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
                    Text('Lihat Semua',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent.shade400)),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // HERO CARD (Ramen)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RecipeDetailScreen(
                                title: 'Ramen Kuah Pedas Buldak',
                                imgUrl:
                                    'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800&auto=format&fit=crop&q=80',
                                ingredients: [
                                  'Mie ramen',
                                  'Saus buldak',
                                  'Keju mozzarella',
                                  'Telur',
                                  'Daun bawang',
                                  'Nori'
                                ],
                                steps: [
                                  'Rebus mie ramen hingga matang, tiriskan',
                                  'Panaskan saus buldak dengan sedikit air',
                                  'Campur mie dengan saus, aduk rata',
                                  'Taburkan keju mozzarella di atasnya',
                                  'Hias dengan telur rebus, daun bawang, dan nori'
                                ],
                              ))),
                  child: Hero(
                    tag: 'hero_image_Ramen Kuah Pedas Buldak',
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 15,
                              offset: const Offset(0, 8))
                        ],
                        image: const DecorationImage(
                            image: NetworkImage(
                                'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800&auto=format&fit=crop&q=80'),
                            fit: BoxFit.cover),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: LinearGradient(
                              colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: const [0.0, 0.7]),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                  color: Colors.amber, borderRadius: BorderRadius.circular(8)),
                              child: const Text('🔥 SPESIAL',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 10,
                                      letterSpacing: 1)),
                            ),
                            const SizedBox(height: 8),
                            const Text('Ramen Kuah Pedas Buldak',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none)),
                            const SizedBox(height: 4),
                            Row(
                              children: const [
                                Icon(Icons.schedule_rounded, color: Colors.white70, size: 16),
                                SizedBox(width: 4),
                                Text('45 Menit',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13,
                                        decoration: TextDecoration.none)),
                                SizedBox(width: 15),
                                Icon(Icons.local_fire_department_rounded,
                                    color: Colors.white70, size: 16),
                                SizedBox(width: 4),
                                Text('Tingkat Sulit',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13,
                                        decoration: TextDecoration.none)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),

              // SEDANG VIRAL
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('Sedang Viral 🔥',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
              ),
              const SizedBox(height: 15),

              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(left: 20),
                  itemCount: _viralRecipes.length,
                  itemBuilder: (context, index) {
                    final item = _viralRecipes[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecipeDetailScreen(
                                    title: item['title'],
                                    imgUrl: item['img'],
                                    ingredients: List<String>.from(item['ingredients'] ?? []),
                                    steps: List<String>.from(item['steps'] ?? []),
                                  ))),
                      child: Container(
                        width: 180,
                        margin: const EdgeInsets.only(right: 16, bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 10,
                                offset: const Offset(0, 6))
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                image: DecorationImage(
                                    image: NetworkImage(item['img']), fit: BoxFit.cover),
                              ),
                              alignment: Alignment.topRight,
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9), shape: BoxShape.circle),
                                child: const Icon(Icons.favorite_border_rounded,
                                    color: Colors.redAccent, size: 18),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['title'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black87),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                  const SizedBox(height: 4),
                                  Text('Oleh ${item['chef']}',
                                      style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [
                                        const Icon(Icons.star_rounded,
                                            color: Colors.amber, size: 16),
                                        Text(' ${item['rating']}',
                                            style: const TextStyle(
                                                fontSize: 12, fontWeight: FontWeight.bold))
                                      ]),
                                      Row(children: [
                                        const Icon(Icons.schedule_rounded,
                                            color: Colors.grey, size: 14),
                                        Text(' ${item['time']}',
                                            style: const TextStyle(fontSize: 11, color: Colors.grey))
                                      ]),
                                    ],
                                  )
                                ],
                              ),
                            )
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
    );
  }
}