import 'package:flutter/material.dart';
import '../models/product.dart';
import '../utils/currency_formatter.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    // Menghitung subtotal per item
    int subtotal = item.product.price * item.quantity;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            // Thumbnail icon/image
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Text(item.product.image, style: const TextStyle(fontSize: 30))),
            ),
            const SizedBox(width: 15),
            // Info Produk
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    CurrencyFormatter.toRupiah(item.product.price),
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Subtotal: ${CurrencyFormatter.toRupiah(subtotal)}",
                    style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ],
              ),
            ),
            // Kontrol Qty dengan AnimatedSwitcher
            Row(
              children: [
                IconButton(
                  onPressed: onDecrease,
                  icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: Text(
                    '${item.quantity}',
                    key: ValueKey<int>(item.quantity),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: onIncrease,
                  icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}