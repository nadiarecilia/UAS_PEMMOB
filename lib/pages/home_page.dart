import 'package:coba_uas/model/product.dart';
import 'package:coba_uas/pages/login_page.dart';
import 'package:coba_uas/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userName;
  late ApiService _apiService;
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = true;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _apiService = Get.find<ApiService>();
    _loadUserData();
    _fetchProducts();
    _searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name') ?? "Pengguna";
    });
  }

  Future<void> _fetchProducts() async {
    try {
      List<Product> products = await _apiService.fetchProducts();
      setState(() {
        _products = products;
        _filteredProducts = products;
        _isLoading = false;
      });
      print("Fetched products: $_products");
    } catch (e) {
      setState(() => _isLoading = false);
      Get.snackbar("Error", "Gagal mengambil produk", backgroundColor: Colors.red, colorText: Colors.white);
      print("Error: $e");
    }
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.snackbar('Success', 'Anda berhasil keluar',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    final filteredProducts = _products.where((product) {
      final productName = product.name.toLowerCase();
      return productName.contains(query);
    }).toList();

    setState(() {
      _filteredProducts = filteredProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = MediaQuery.of(context).size.width > 600 ? 3 : 2;

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Colors.pink[400],
            child: Text(
              'Bengkel Otomotif Jaya Makmur',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Body content
          Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                    ),
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Cari produk...',
                            prefixIcon: Icon(Icons.search, color: Colors.pink[400]),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.pink[50],
                          ),
                        ),
                      ),
                      Expanded(
                        child: _filteredProducts.isEmpty
                            ? Center(
                                child: Text(
                                  "Tidak ada produk tersedia",
                                  style: TextStyle(color: Colors.pink),
                                ),
                              )
                            : GridView.builder(
                                padding: EdgeInsets.all(10),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  childAspectRatio: 0.75,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: _filteredProducts.length,
                                itemBuilder: (context, index) {
                                  final product = _filteredProducts[index];
                                  String imageUrl = product.imageUrl ?? '';

                                  var description = product.description;
                                  return Card(
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    color: Colors.pink[50],
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.grey[200],
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 5,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: imageUrl.isEmpty
                                                  ? Center(
                                                      child: Icon(
                                                        Icons.image,
                                                        size: 50,
                                                        color: Colors.pink[200],
                                                      ),
                                                    )
                                                  : ClipRRect(
                                                      borderRadius: BorderRadius.circular(10),
                                                      child: Image.network(
                                                        'http://localhost/storage/$imageUrl',
                                                        fit: BoxFit.cover,
                                                        loadingBuilder:
                                                            (context, child, loadingProgress) {
                                                          if (loadingProgress == null) {
                                                            return child;
                                                          }
                                                          return Center(
                                                            child: CircularProgressIndicator(),
                                                          );
                                                        },
                                                        errorBuilder: (context, error, stackTrace) {
                                                          return Center(
                                                              child: Icon(
                                                                  Icons.broken_image,
                                                                  size: 50,
                                                                  color: Colors.pink[200]));
                                                        },
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            product.name,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.pink[700],
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            description!,
                                            style: TextStyle(fontSize: 14, color: Colors.pink[300]),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "Rp ${product.price.toStringAsFixed(2)}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.pink[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
