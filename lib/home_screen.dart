import 'package:flutter/material.dart';
import 'package:product/add_product_screen.dart';
import 'package:product/product_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddProductScreen(),
                    )).then((value) => setState(() {}));
              },
              child: const Text("Tambah Produk")),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: StreamBuilder<Map<String, String>>(
            stream: _productService.getProductList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<String, String> items = snapshot.data!;
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final key = items.keys.elementAt(index);
                    final item = items[key];
                    return ListTile(
                      title: Text(item!),
                      leading: Text(item),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _productService.removeProductItem(key);
                        },
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.hasError}"),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ))
        ],
      ),
    );
  }
}
