import 'package:flutter/material.dart';
import 'package:my_coffee/cart_provider.dart';
import 'package:my_coffee/splash_screen.dart';
import 'package:my_coffee/wishList_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => CartProvider()),
      ChangeNotifierProvider(create: (_) => WishListProvider()),
    ],
    child: const MyCoffee(),)
  );
}

class MyCoffee extends StatelessWidget {
  const MyCoffee({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}


