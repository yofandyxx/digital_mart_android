import 'package:flutter/material.dart';
import '../models/product.dart';
import '../utils/currency_formatter.dart';
import '../screens/detail_screen.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback onAdd;

  const ProductCard({super.key, required this.product, required this.onAdd});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Efek Interaktif saat ditekan
      onTapDown: (_) => setState(() => scale = 0.95),
      onTapUp: (_) => setState(() => scale = 1.0),
      onTapCancel: () => setState(() => scale = 1.0),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              product: widget.product,
              onAdd: widget.onAdd,
            ),
          ),
        );
      },
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 100),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Animation untuk transisi gambar ke detail
              Expanded(
                child: Hero(
                  tag: 'product-img-${widget.product.id}',
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                    ),
                    width: double.infinity,
                    child: Center(
                      child: Text(widget.product.image, style: const TextStyle(fontSize: 50)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      CurrencyFormatter.toRupiah(widget.product.price),
                      style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < widget.product.rating ? Icons.star : Icons.star_border,
                          size: 14,
                          color: Colors.orange,
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: widget.onAdd,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text("Tambah", style: TextStyle(fontSize: 12)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}