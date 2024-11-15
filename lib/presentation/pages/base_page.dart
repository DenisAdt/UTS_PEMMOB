import 'package:flutter/material.dart';
import 'home_page.dart'; // Pastikan Anda memiliki HomePage yang diimpor
import 'cart_page.dart'; // Pastikan Anda memiliki CartPage yang diimpor
import 'settings_page.dart'; // Pastikan Anda memiliki SettingsPage yang diimpor

class BasePage extends StatefulWidget {
  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _selectedIndex = 0;
  late PageController _pageController;

  // Daftar untuk menyimpan item keranjang
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  // Fungsi untuk menambahkan item ke keranjang
  void addToCart(String name, int price) {
    setState(() {
      cartItems.add({'name': name, 'price': price});
    });
  }

  // Fungsi untuk menghapus item dari keranjang
  void removeFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomePage(
            searchQuery: '',
            addToCart: addToCart, // Kirim fungsi addToCart ke HomePage
          ),
          CartPage(
            cartItems: cartItems, // Kirim cartItems ke CartPage
            onRemoveItem: removeFromCart, // Kirim fungsi untuk menghapus item
          ),
          SettingsPage(), // Pastikan SettingsPage sudah ada
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), // Ikon keranjang belanja
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
