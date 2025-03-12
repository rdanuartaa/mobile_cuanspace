import 'package:flutter/material.dart';

// Model untuk data UMKM
class UmkmModel {
  final String id;
  final String name;
  final String category;
  final String location;
  final String imageUrl;
  final double rating;
  final String description;
  final List<String> products;

  UmkmModel({
    required this.id,
    required this.name,
    required this.category,
    required this.location,
    required this.imageUrl,
    required this.rating,
    required this.description,
    required this.products,
  });
}

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'Semua';
  
  // Data contoh pelaku UMKM
  final List<UmkmModel> _umkmList = [
    UmkmModel(
      id: '1',
      name: 'Batik Jember',
      category: 'Kerajinan',
      location: 'Jember',
      imageUrl: 'https://example.com/batik.jpg',
      rating: 4.8,
      description: 'Batik khas Jember dengan motif tembakau dan kopi yang unik. Tersedia berbagai produk seperti kain, baju, dan aksesoris.',
      products: ['Kain Batik', 'Kemeja Batik', 'Selendang'],
    ),
    UmkmModel(
      id: '2',
      name: 'Kopi Rambipuji',
      category: 'Makanan & Minuman',
      location: 'Jember',
      imageUrl: 'https://example.com/kopi.jpg',
      rating: 4.6,
      description: 'Kopi arabika premium dari perkebunan di dataran tinggi Jember dengan aroma yang khas dan cita rasa yang kuat.',
      products: ['Biji Kopi Arabika', 'Kopi Bubuk', 'Kopi Sachetan'],
    ),
    UmkmModel(
      id: '3',
      name: 'Kerajinan Bambu Tutul',
      category: 'Kerajinan',
      location: 'Jember',
      imageUrl: 'https://example.com/bamboo.jpg',
      rating: 4.5,
      description: 'Aneka kerajinan bambu berkualitas dengan desain unik dan modern. Produk tahan lama dan ramah lingkungan.',
      products: ['Kursi Bambu', 'Meja Bambu', 'Hiasan Dinding'],
    ),
    UmkmModel(
      id: '4',
      name: 'Tape Bondowoso',
      category: 'Makanan & Minuman',
      location: 'Bondowoso',
      imageUrl: 'https://example.com/tape.jpg',
      rating: 4.7,
      description: 'Tape singkong khas Bondowoso dengan rasa yang manis dan tekstur yang lembut. Oleh-oleh favorit dari Bondowoso.',
      products: ['Tape Singkong', 'Suwar-suwir', 'Prol Tape'],
    ),
    UmkmModel(
      id: '5',
      name: 'Tembakau Jember',
      category: 'Pertanian',
      location: 'Jember',
      imageUrl: 'https://example.com/tobacco.jpg',
      rating: 4.9,
      description: 'Tembakau kualitas premium dari perkebunan Jember. Dikenal dengan aroma yang khas dan kualitas terbaik.',
      products: ['Tembakau Kering', 'Cerutu', 'Bibit Tembakau'],
    ),
    UmkmModel(
      id: '6',
      name: 'Bordir Tasikmalaya',
      category: 'Fashion',
      location: 'Tasikmalaya',
      imageUrl: 'https://example.com/bordir.jpg',
      rating: 4.7,
      description: 'Bordir halus dengan motif tradisional dan kontemporer. Dibuat oleh pengrajin terampil dengan pengalaman bertahun-tahun.',
      products: ['Mukena Bordir', 'Baju Bordir', 'Tas Bordir'],
    ),
  ];

  // Mendapatkan daftar kategori unik dari data UMKM
  List<String> get _categories {
    final categories = _umkmList.map((umkm) => umkm.category).toSet().toList();
    categories.insert(0, 'Semua');
    return categories;
  }

  // Filter UMKM berdasarkan pencarian dan kategori
  List<UmkmModel> get _filteredUmkmList {
    return _umkmList.where((umkm) {
      final matchesSearch = umkm.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          umkm.location.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          umkm.description.toLowerCase().contains(_searchQuery.toLowerCase());
      
      final matchesCategory = _selectedCategory == 'Semua' || umkm.category == _selectedCategory;
      
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temukan UMKM'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari UMKM, produk, atau lokasi...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // Category Filter
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: _categories.map((category) {
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    selected: isSelected,
                    label: Text(category),
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    selectedColor: Colors.blue.shade100,
                    backgroundColor: Colors.grey.shade200,
                    checkmarkColor: Colors.blue,
                  ),
                );
              }).toList(),
            ),
          ),

          // Result count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  'Menampilkan ${_filteredUmkmList.length} UMKM',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // UMKM List
          Expanded(
            child: _filteredUmkmList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 16),
                        Text(
                          'Tidak ada UMKM yang ditemukan',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 8, bottom: 24),
                    itemCount: _filteredUmkmList.length,
                    itemBuilder: (context, index) {
                      final umkm = _filteredUmkmList[index];
                      return UmkmCard(
                        umkm: umkm,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UmkmDetailPage(umkm: umkm),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// Widget kartu UMKM yang dapat diklik
class UmkmCard extends StatelessWidget {
  final UmkmModel umkm;
  final VoidCallback onTap;

  const UmkmCard({
    super.key,
    required this.umkm,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar UMKM
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.store,
                  size: 48,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama UMKM dan Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          umkm.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            umkm.rating.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Kategori dan Lokasi
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          umkm.category,
                          style: TextStyle(
                            color: Colors.blue.shade800,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.location_on, size: 16, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        umkm.location,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Deskripsi singkat
                  Text(
                    umkm.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Tombol aksi
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {
                          // Fungsi untuk chat dengan UMKM
                        },
                        icon: const Icon(Icons.chat_bubble_outline, size: 16),
                        label: const Text('Chat'),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: onTap,
                        icon: const Icon(Icons.store, size: 16),
                        label: const Text('Lihat Profil'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman detail UMKM
class UmkmDetailPage extends StatelessWidget {
  final UmkmModel umkm;

  const UmkmDetailPage({super.key, required this.umkm});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(umkm.name),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar header
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey.shade300,
              child: Center(
                child: Icon(
                  Icons.store,
                  size: 64,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            
            // Informasi utama
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama dan Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          umkm.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12, 
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              umkm.rating.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Kategori dan Lokasi
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          umkm.category,
                          style: TextStyle(
                            color: Colors.blue.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(Icons.location_on, color: Colors.grey.shade700),
                      const SizedBox(width: 4),
                      Text(
                        umkm.location,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Deskripsi
                  const Text(
                    'Tentang UMKM',
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    umkm.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade800,
                      height: 1.5,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Produk
                  const Text(
                    'Produk & Layanan',
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Daftar produk
                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: umkm.products.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 140,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Gambar produk
                              Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                                child: Center(
                                  child: Icon(Icons.image, color: Colors.grey.shade400),
                                ),
                              ),
                              
                              // Nama produk
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  umkm.products[index],
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Ulasan
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Ulasan',
                        style: TextStyle(
                          fontSize: 18, 
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigasi ke halaman ulasan lengkap
                        },
                        child: const Text('Lihat Semua'),
                      ),
                    ],
                  ),
                  
                  // Contoh ulasan
                  _buildReviewItem(
                    name: 'Ahmad S.',
                    rating: 5,
                    date: '2 hari yang lalu',
                    comment: 'Pelayanan sangat baik dan responsif. Produk berkualitas tinggi dan sesuai dengan deskripsi.',
                  ),
                  
                  _buildReviewItem(
                    name: 'Budi W.',
                    rating: 4,
                    date: '1 minggu yang lalu',
                    comment: 'Saya sangat puas dengan produk yang saya beli. Pengiriman cepat dan aman.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      
      // Bottom action buttons
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Chat button
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // Chat dengan penjual
                },
                icon: const Icon(Icons.chat_bubble_outline),
                label: const Text('Chat'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            
            // Order button
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Pesan produk
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Pesan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Widget untuk item ulasan
  Widget _buildReviewItem({
    required String name,
    required int rating,
    required String date,
    required String comment,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                date,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 16,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(comment),
        ],
      ),
    );
  }
}