import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Product> products = [
    Product(
      id: 1,
      name: "Laptop Pro 14",
      description: "High performance laptop for creators.",
      price: 15000000,
      image: "💻",
      rating: 4.8,
    ),
    Product(
      id: 2,
      name: "Smartphone X",
      description: "Flagship smartphone with amazing camera.",
      price: 8500000,
      image: "📱",
      rating: 4.5,
    ),
    Product(
      id: 3,
      name: "Wireless Buds",
      description: "Clear sound with noise cancellation.",
      price: 1200000,
      image: "🎧",
      rating: 4.2,
    ),
    Product(
      id: 4,
      name: "Smartwatch G3",
      description: "Track your health and activities.",
      price: 2500000,
      image: "⌚",
      rating: 4.0,
    ),
  ];

  List<CartItem> cart = [];

  void addToCart(Product product) {
    setState(() {
      final index = cart.indexWhere((item) => item.product.id == product.id);
      if (index >= 0) {
        cart[index].quantity++;
      } else {
        cart.add(CartItem(product: product));
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${product.name} ditambah ke keranjang"),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    int crossAxisCount = size.width > 600 ? 4 : 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Digital Mart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, anim, secAnim) =>
                        CartScreen(cart: cart),
                    transitionsBuilder: (context, anim, secAnim, child) {
                      return FadeTransition(opacity: anim, child: child);
                    },
                  ),
                ).then((_) => setState(() {})),
              ),
              if (cart.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${cart.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 0.7,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(product: product, onAdd: () => addToCart(product));
        },
      ),
    );
  }
}
