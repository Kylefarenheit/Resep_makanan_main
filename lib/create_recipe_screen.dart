import 'package:flutter/material.dart';

class CreateRecipeScreen extends StatefulWidget {
  const CreateRecipeScreen({super.key});

  @override
  State<CreateRecipeScreen> createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {
  String _selectedPorsi = '2 Orang';
  
  // List controller untuk form bahan (dinamis)
  final List<TextEditingController> _ingredientControllers = [TextEditingController()];

  @override
  void dispose() {
    // Memastikan memory leak tidak terjadi
    for (var controller in _ingredientControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addIngredientRow() {
    setState(() {
      _ingredientControllers.add(TextEditingController());
    });
  }

  void _removeIngredientRow(int index) {
    setState(() {
      _ingredientControllers[index].dispose(); // Bersihkan memory
      _ingredientControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      
      // APP BAR BERSIH
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.black87, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Buat Resep', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w800, fontSize: 20)),
        centerTitle: true,
      ),

      // TOMBOL TERBITKAN (STICKY DI BAWAH)
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 10, 24, 20),
          child: Container(
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Resep sedang diproses dan diterbitkan! 🚀'),
                    behavior: SnackBarBehavior.floating,
                  )
                );
                Future.delayed(const Duration(seconds: 1), () => Navigator.pop(context));
              },
              child: const Text('Terbitkan Resep', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 0.5)),
            ),
          ),
        ),
      ),

      // KONTEN FORM
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            // AREA UPLOAD FOTO ESTETIK
            InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Membuka Galeri...'))),
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey.shade300, width: 2, style: BorderStyle.solid),
                  boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 10, offset: const Offset(0, 5))],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(color: Colors.red.shade50, shape: BoxShape.circle),
                      child: Icon(Icons.add_photo_alternate_rounded, size: 40, color: Colors.redAccent.shade400),
                    ),
                    const SizedBox(height: 12),
                    const Text('Unggah Foto Masakan', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text('Maksimal ukuran 5MB', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // INPUT JUDUL MASAKAN
            const Text('Judul Masakan', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.black87)),
            const SizedBox(height: 10),
            _buildCustomTextField(hint: 'Misal: Nasi Goreng Gila Spesial', icon: Icons.restaurant_menu_rounded),
            const SizedBox(height: 25),

            // BARIS PORSI & WAKTU
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Porsi Sajian', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.black87)),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 10, offset: const Offset(0, 5))],
                          border: Border.all(color: Colors.grey.shade100),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedPorsi,
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
                            style: const TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w600),
                            items: ['1 Orang', '2 Orang', '3-5 Orang', 'Porsi Besar'].map((String value) {
                              return DropdownMenuItem<String>(value: value, child: Text(value));
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() { _selectedPorsi = newValue!; });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Durasi (Menit)', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.black87)),
                      const SizedBox(height: 10),
                      _buildCustomTextField(hint: 'Misal: 45', icon: Icons.timer_outlined, isNumber: true),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 35),

            // BAGIAN BAHAN-BAHAN
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Bahan Masakan', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black87)),
                TextButton.icon(
                  onPressed: _addIngredientRow,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red.shade50,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  icon: Icon(Icons.add_rounded, size: 18, color: Colors.redAccent.shade400),
                  label: Text('Bahan', style: TextStyle(color: Colors.redAccent.shade400, fontWeight: FontWeight.bold)),
                )
              ],
            ),
            const SizedBox(height: 15),

            // DAFTAR BAHAN (ANIMATED SIZE AGAR SMOOTH SAAT DITAMBAH/DIHAPUS)
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _ingredientControllers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        // Ikon penanda list
                        Container(
                          width: 10, height: 10,
                          margin: const EdgeInsets.only(right: 15),
                          decoration: BoxDecoration(color: Colors.redAccent.shade100, shape: BoxShape.circle),
                        ),
                        // Input teks bahan
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 8, offset: const Offset(0, 4))],
                              border: Border.all(color: Colors.grey.shade100),
                            ),
                            child: TextField(
                              controller: _ingredientControllers[index],
                              decoration: InputDecoration(
                                hintText: 'Contoh: 2 Siung Bawang Putih',
                                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                              ),
                            ),
                          ),
                        ),
                        // Tombol Hapus (Muncul jika baris lebih dari 1)
                        if (_ingredientControllers.length > 1)
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline_rounded, color: Colors.redAccent),
                            onPressed: () => _removeIngredientRow(index),
                          )
                        else
                          const SizedBox(width: 48), // Spacer pengganti icon agar sejajar
                      ],
                    ),
                  );
                },
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget bantuan untuk Textfield
  Widget _buildCustomTextField({required String hint, required IconData icon, bool isNumber = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 10, offset: const Offset(0, 5))],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: TextField(
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          prefixIcon: Icon(icon, color: Colors.grey.shade400, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }
}