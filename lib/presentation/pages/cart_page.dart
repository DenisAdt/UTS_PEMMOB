import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final Function(int) onRemoveItem; // Fungsi untuk menghapus item

  CartPage({Key? key, required this.cartItems, required this.onRemoveItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang Belanja'),
        backgroundColor: Colors.green,
      ),
      body: cartItems.isEmpty
          ? Center(child: Text('Keranjang Anda kosong'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(cartItems[index]['name']),
                    subtitle: Text('Harga: Rp ${cartItems[index]['price']}'),
                    trailing: IconButton(
                      icon: Icon(Icons.cancel, color: Colors.red),
                      onPressed: () {
                        onRemoveItem(index); // Panggil fungsi untuk menghapus item
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
