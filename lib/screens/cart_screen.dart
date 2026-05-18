import 'package:flutter/material.dart';
import '../models/product.dart';
import '../utils/currency_formatter.dart';

class CartScreen extends StatefulWidget {
  final List<CartItem> cart;
  const CartScreen({super.key, required this.cart});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int get totalPrice => widget.cart.fold(
    0,
    (sum, item) => sum + (item.product.price * item.quantity),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Keranjang")),
      body: widget.cart.isEmpty
          ? const Center(child: Text("Keranjang Kosong"))
          : ListView.builder(
              itemCount: widget.cart.length,
              itemBuilder: (context, index) {
                final item = widget.cart[index];
                return ListTile(
                  leading: Text(
                    item.product.image,
                    style: const TextStyle(fontSize: 24),
                  ),
                  title: Text(item.product.name),
                  subtitle: Text(
                    "${CurrencyFormatter.toRupiah(item.product.price)} x ${item.quantity}",
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () => setState(() {
                          if (item.quantity > 1) {
                            item.quantity--;
                          } else {
                            widget.cart.removeAt(index);
                          }
                        }),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          '${item.quantity}',
                          key: ValueKey(item.quantity),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () => setState(() => item.quantity++),
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              CurrencyFormatter.toRupiah(totalPrice),
              style: const TextStyle(
                fontSize: 18,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
