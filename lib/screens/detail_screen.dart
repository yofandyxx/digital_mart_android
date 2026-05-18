import 'package:flutter/material.dart';
import '../models/product.dart';
import '../utils/currency_formatter.dart';

class DetailScreen extends StatelessWidget {
  final Product product;
  final VoidCallback onAdd;
  const DetailScreen({super.key, required this.product, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: 'product-img-${product.id}',
              child: Container(
                height: 300,
                width: double.infinity,
                color: Colors.grey[200],
                child: Center(
                  child: Text(
                    product.image,
                    style: const TextStyle(fontSize: 100),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    CurrencyFormatter.toRupiah(product.price),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Deskripsi",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(product.description),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: onAdd,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Tambah ke Keranjang"),
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
