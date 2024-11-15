import 'package:flutter/material.dart';
import 'cart_page.dart'; // Pastikan Anda memiliki CartPage yang diimpor

class HomePage extends StatefulWidget {
  final String searchQuery;
  final Function(String, int) addToCart; // Tambahkan parameter untuk fungsi addToCart

  HomePage({Key? key, required this.searchQuery, required this.addToCart}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> productNames = [
    'Beras Premium',
    'Ayam Fillet Segar',
    'Sayur Kangkung',
    'Apel Fuji',
    'Cabai Merah'
  ];
  List<int> productPrices = [50000, 30000, 5000, 25000, 20000];

  // List untuk hasil pencarian
  List<String> filteredNames = [];
  List<int> filteredPrices = [];

  @override
  void initState() {
    super.initState();
    filteredNames = List.from(productNames);
    filteredPrices = List.from(productPrices);
    _searchController.text = widget.searchQuery;
    _searchProduct(widget.searchQuery);
  }

  void _searchProduct(String query) {
    final List<String> results = [];
    final List<int> priceResults = [];

    if (query.isEmpty) {
      results.addAll(productNames);
      priceResults.addAll(productPrices);
    } else {
      for (int i = 0; i < productNames.length; i++) {
        if (productNames[i].toLowerCase().contains(query.toLowerCase())) {
          results.add(productNames[i]);
          priceResults.add(productPrices[i]);
        }
      }
    }

    setState(() {
      filteredNames = results;
      filteredPrices = priceResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marketplace Bahan Pangan'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          // Banner
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/banner.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Pencarian Produk
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari bahan pangan...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: _searchProduct,
            ),
          ),

          // Kategori
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CategoryItem(title: 'Beras'),
                CategoryItem(title: 'Daging'),
                CategoryItem(title: 'Sayuran'),
                CategoryItem(title: 'Buah'),
                CategoryItem(title: 'Rempah'),
              ],
            ),
          ),

          // Daftar Produk (Hasil Pencarian)
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: filteredNames.length,
              itemBuilder: (context, index) {
                return productItem(filteredNames[index], filteredPrices[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget productItem(String name, int price) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(Icons.fastfood, size: 40, color: Colors.green),
        title: Text(name),
        subtitle: Text('Harga: Rp $price'),
        trailing: ElevatedButton(
          onPressed: () => widget.addToCart(name, price), // Panggil fungsi addToCart dari BasePage
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: Text('Beli'),
        ),
      ),
    );
  }

  Widget CategoryItem({required String title}) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
