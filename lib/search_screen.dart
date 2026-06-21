import 'package:flutter/material.dart';
import 'recipe_detail_screen.dart'; // Sesuaikan dengan file detail Anda

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchQuery = '';
  
  // Data mock semua resep
  final List<Map<String, String>> _allRecipes = [
    {'title': 'Rendang Sapi Padang', 'chef': 'Gordon Ramsay', 'img': 'https://images.unsplash.com/photo-1601050690597-df056fb4ce78?w=600&auto=format&fit=crop&q=60'},
    {'title': 'Soto Ayam Lamongan', 'chef': 'Chef Juna', 'img': 'https://images.unsplash.com/photo-1541832676-9b763b0239ab?w=600&auto=format&fit=crop&q=60'},
    {'title': 'Ayam Bakar Madu', 'chef': 'Chef Fadly Rizky', 'img': 'https://images.unsplash.com/photo-1532550907401-a500c9a57435?w=500&auto=format&fit=crop&q=60'},
    {'title': 'Sop Buntut Sapi', 'chef': 'Chef Renatta', 'img': 'https://images.unsplash.com/photo-1547592180-85f173990554?w=500&auto=format&fit=crop&q=60'},
  ];

  @override
  Widget build(BuildContext context) {
    // Logika menyaring daftar resep berdasarkan ketikan user
    final filteredRecipes = _allRecipes.where((recipe) {
      return recipe['title']!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            // Header & Search Bar
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 10, offset: const Offset(0, 5))],
                      ),
                      child: TextField(
                        autofocus: true, // Otomatis memunculkan keyboard
                        onChanged: (value) => setState(() => _searchQuery = value),
                        decoration: const InputDecoration(
                          hintText: 'Cari resep favoritmu...',
                          border: InputBorder.none,
                          icon: Icon(Icons.search_rounded, color: Colors.redAccent),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Hasil Pencarian
            Expanded(
              child: filteredRecipes.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off_rounded, size: 80, color: Colors.grey.shade300),
                          const SizedBox(height: 16),
                          Text('Resep tidak ditemukan', style: TextStyle(color: Colors.grey.shade500, fontSize: 16)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: filteredRecipes.length,
                      itemBuilder: (context, index) {
                        final recipe = filteredRecipes[index];
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(vertical: 8),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(recipe['img']!, width: 60, height: 60, fit: BoxFit.cover),
                          ),
                          title: Text(recipe['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('Oleh ${recipe['chef']}'),
                          trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetailScreen(title: recipe['title']!, imgUrl: recipe['img']!)));
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}