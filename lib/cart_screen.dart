import 'package:flutter/material.dart';
import 'package:my_coffee/cart_provider.dart';
import 'package:my_coffee/checkout_screen.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;

    return Scaffold(
      backgroundColor: Color(0xFFE47777),
      body: cartItems.isEmpty
          ? Center(
              child: Text(
                'Your cart is empty!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
                  margin: EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    leading: Image.asset(
                      item.image,
                      width: 100,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.category),
                        SizedBox(height: 4),
                        Text(
                          'Price: \$${item.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (item.quantity > 1) {
                                  cartProvider.decreaseQuantity(item.title);
                                } else {
                                  cartProvider.removeItem(item.title);
                                }
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            Text(
                              '${item.quantity}',
                              style: TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              onPressed: () {
                                cartProvider.increaseQuantity(item.title);
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        )
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        cartProvider.removeItem(item.title);
                      },
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: cartItems.isNotEmpty
          ? Padding(
              padding: EdgeInsets.all(12),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3A1111),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CheckoutScreen(),
                    ),
                  );
                },
                child: Text(
                  'Checkout',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
