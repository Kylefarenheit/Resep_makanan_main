import 'package:flutter/material.dart';

class RecipeDetailScreen extends StatefulWidget {
  final String title;
  final String imgUrl;
  final List<String> ingredients;
  final List<String> steps;
  final String rating;
  final String time;
  final String difficulty;
  final String calories;
  final String protein;
  final String carbs;
  final String fat;

 const RecipeDetailScreen({
  super.key,
  required this.title,
  required this.imgUrl,
  this.ingredients = const [],
  this.steps = const [],
  this.rating = '4.8',
  this.time = '30 Menit',
  this.difficulty = 'Mudah',
  this.calories = '350',
  this.protein = '15g',
  this.carbs = '25g',
  this.fat = '10g',
});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  bool _isFavorite = false;
  int _activeTab = 0; // 0 untuk Bahan, 1 untuk Langkah
  int _porsiCount = 2; // Counter porsi interaktif

  // 💡 State checklist sekarang fleksibel, diinisialisasi saat layar dibuka
  late List<bool> _checkedIngredients;

  @override
  void initState() {
    super.initState();
    // Membuat jumlah checklist otomatis sama dengan jumlah bahan yang dikirim
    _checkedIngredients = List<bool>.filled(widget.ingredients.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. COLLAPSING HEADER (SLIVER APP BAR)
          SliverAppBar(
            expandedHeight: 380,
            elevation: 0,
            pinned: true,
            backgroundColor: Colors.white,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.85),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.85),
                  child: IconButton(
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        _isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                        color: _isFavorite ? Colors.redAccent : Colors.black87,
                        key: ValueKey<bool>(_isFavorite),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _isFavorite = !_isFavorite;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(_isFavorite ? 'Ditambahkan ke Koleksi ❤️' : 'Dihapus dari Koleksi'),
                          duration: const Duration(milliseconds: 800),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'hero_image_${widget.title}',
                    child: Image.network(widget.imgUrl, fit: BoxFit.cover),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.1),
                          Colors.transparent,
                          Colors.white.withOpacity(0.8),
                          Colors.white,
                        ],
                        stops: const [0.0, 0.4, 0.85, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. KONTEN UTAMA DETAIL RESEP
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // JUDUL RESEP PREMIUM (Dinamis)
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: Colors.black87,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // DETAIL INFO (Dinamis dari widget data)
                    Row(
                      children: [
                        _buildHeaderMeta(Icons.star_rounded, Colors.amber, '${widget.rating} (Ulasan)'),
                        const SizedBox(width: 15),
                        _buildHeaderMeta(Icons.schedule_rounded, Colors.grey.shade600, widget.time),
                        const SizedBox(width: 15),
                        _buildHeaderMeta(Icons.restaurant_rounded, Colors.redAccent, widget.difficulty),
                      ],
                    ),
                    const SizedBox(height: 25),

                    // KARTU INFORMASI NUTRISI (Dinamis dari widget data)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildNutritionCard(widget.calories, 'Kalori', Colors.red.shade50, Colors.redAccent),
                        _buildNutritionCard(widget.protein, 'Protein', Colors.orange.shade50, Colors.orangeAccent),
                        _buildNutritionCard(widget.carbs, 'Karbo', Colors.blue.shade50, Colors.blueAccent),
                        _buildNutritionCard(widget.fat, 'Lemak', Colors.purple.shade50, Colors.purpleAccent),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // PENYESUAIAN PORSI INTERAKTIF
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Porsi Sajian', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_rounded, color: Colors.black54),
                                onPressed: () {
                                  if (_porsiCount > 1) setState(() => _porsiCount--);
                                },
                              ),
                              Text(
                                '$_porsiCount',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add_rounded, color: Colors.black54),
                                onPressed: () => setState(() => _porsiCount++),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // CUSTOM SEGMENTED TAB SWITCHER
                    Container(
                      height: 55,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          _buildTabButton(title: 'Bahan-Bahan', index: 0),
                          _buildTabButton(title: 'Langkah Memasak', index: 1),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),

                    // KONTEN DINAMIS BERDASARKAN TAB YANG AKTIF
                    _activeTab == 0
                        ? _buildIngredientsSection()
                        : _buildStepsSection(),

                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }

  Widget _buildHeaderMeta(IconData icon, Color iconColor, String text) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 18),
        const SizedBox(width: 5),
        Text(text, style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildNutritionCard(String value, String label, Color bgColor, Color textColor) {
    return Container(
      width: 75,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildTabButton({required String title, required int index}) {
    bool isSelected = _activeTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _activeTab = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))]
                : [],
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.redAccent.shade400 : Colors.grey.shade500,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  // TAB CONTENT 1: LIST BAHAN DINAMIS
  Widget _buildIngredientsSection() {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.ingredients.length,
      itemBuilder: (context, index) {
        bool isChecked = _checkedIngredients[index];
        return InkWell(
          onTap: () {
            setState(() {
              _checkedIngredients[index] = !_checkedIngredients[index];
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            decoration: BoxDecoration(
              color: isChecked ? Colors.red.shade50.withOpacity(0.3) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  isChecked ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                  color: isChecked ? Colors.redAccent : Colors.grey.shade400,
                  size: 22,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    widget.ingredients[index],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: isChecked ? FontWeight.w500 : FontWeight.w600,
                      color: isChecked ? Colors.grey.shade400 : Colors.black87,
                      decoration: isChecked ? TextDecoration.lineThrough : TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // TAB CONTENT 2: TIMELINE LANGKAH MEMASAK DINAMIS
  Widget _buildStepsSection() {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.steps.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color: Colors.redAccent.shade400,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.redAccent.withOpacity(0.3), blurRadius: 6, offset: const Offset(0, 3)),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Langkah ${index + 1}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.steps[index],
                      style: TextStyle(color: Colors.grey.shade700, fontSize: 14, height: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}