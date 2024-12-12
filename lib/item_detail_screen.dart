import 'package:flutter/material.dart';
import 'package:my_coffee/cart_provider.dart';
import 'package:provider/provider.dart';

class ItemDetailsPopup extends StatefulWidget {
  final String title;
  final String category;
  final String image;
  final int price;

  const ItemDetailsPopup({
    super.key,
    required this.title,
    required this.category,
    required this.image,
    required this.price,
  });

  @override
  State<ItemDetailsPopup> createState() => _ItemDetailsPopupState();
}

class _ItemDetailsPopupState extends State<ItemDetailsPopup> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Container(
      margin: EdgeInsets.all(36),
      padding: EdgeInsets.all(26),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF932E2E), Color(0xFF130101)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              widget.image,
              height: 180,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 12),
          //Title
          Center(
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 6),
          Text(
            widget.category,
            style: TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic,
              color: Colors.white60,
            ),
          ),
          SizedBox(height: 16),
          //Quantity Selector
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (quantity > 1) {
                    setState(() {
                      quantity--;
                    });
                  }
                },
                icon: Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
              ),
              Text(
                '$quantity',
                style: TextStyle(fontSize: 18, color: Colors.white60),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    quantity++;
                  });
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  final cartItem = CartItem(
                    title: widget.title,
                    image: widget.image,
                    category: widget.category,
                    price: widget.price,
                    quantity: quantity,
                  );
                  cartProvider.addItem(cartItem);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${widget.title} added to cart!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                child: Text(
                  "Add to Cart",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
