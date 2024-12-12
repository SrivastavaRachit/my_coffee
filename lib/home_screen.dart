import 'package:flutter/material.dart';
import 'package:my_coffee/cart_screen.dart';
import 'package:my_coffee/custom_bottom_navigation_bar.dart';
import 'package:my_coffee/profile_screen.dart';
import 'package:my_coffee/wishList_provider.dart';
import 'package:my_coffee/wishlist_screen.dart';
import 'package:provider/provider.dart';
import 'item_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const HomeScreenContent(),
    const CartScreen(),
    const WishListScreen(),
    const ProfileScreen(),
  ];

  void _onNavigationTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4B2C20),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2B0909), Color(0xFF956421)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 2,
        title: Text(
          "Coffee Shop",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: _onNavigationTap,
      ),
    );
  }
}

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  String selectedCategory = 'Popular';

  final List<Map<String, dynamic>> coffeeList = [
    // Popular Items
    {
      'title': 'CARAMEL\nMACCHIATO',
      'category': 'Popular',
      'image': 'assets/caramel.jpg',
      'price': 230,
    },
    {
      'title': 'VANILLA\nLATTE',
      'category': 'Popular',
      'image': 'assets/vanila.jpg',
      'price': 210,
    },

    // Black Coffee
    {
      'title': 'ICED\nAMERICANO',
      'category': 'Black Coffee',
      'image': 'assets/icedamericano.jpg',
      'price': 150,
    },
    {
      'title': 'ESPRESSO',
      'category': 'Black coffee',
      'image': 'assets/espresso.jpg',
      'price': 250,
    },
    {
      'title': 'LONG BLACK',
      'category': 'Black coffee',
      'image': 'assets/long_black.jpg',
      'price': 170,
    },

    // Winter Special
    {
      'title': 'CAPPUCCINO\nLATTE',
      'category': 'Winter special',
      'image': 'assets/cappuccino.jpg',
      'price': 180,
    },
    {
      'title': 'GINGERBREAD\nLATTE',
      'category': 'Winter special',
      'image': 'assets/gingerbread.jpg',
      'price': 220,
    },
    {
      'title': 'PEPPERMINT\nMOCHA',
      'category': 'Winter special',
      'image': 'assets/peppermint.jpg',
      'price': 240,
    },

    // Decaf Options
    {
      'title': 'SILKY CAFE\nAU LAIT',
      'category': 'Decaf',
      'image': 'assets/silky.jpg',
      'price': 200,
    },
    {
      'title': 'DECAF\nAMERICANO',
      'category': 'Decaf',
      'image': 'assets/decaf.jpg',
      'price': 180,
    },

    // Chocolate Drinks
    {
      'title': 'ICED\nCHOCOLATE',
      'category': 'Chocolate',
      'image': 'assets/icedamericano.jpg',
      'price': 120,
    },
    {
      'title': 'HOT\nCHOCOLATE',
      'category': 'Chocolate',
      'image': 'assets/hot.jpg',
      'price': 160,
    },
    {
      'title': 'WHITE\nMOCHA',
      'category': 'Chocolate',
      'image': 'assets/white_mocha.jpg',
      'price': 200,
    },

    // Herbal Tea
    {
      'title': 'CHAMOMILE\nTEA',
      'category': 'Herbal Tea',
      'image': 'assets/chamomile.jpg',
      'price': 130,
    },
    {
      'title': 'LEMONGRASS\nTEA',
      'category': 'Herbal Tea',
      'image': 'assets/lemongrass_tea.jpg',
      'price': 140,
    },
    {
      'title': 'MINT\nTEA',
      'category': 'Herbal Tea',
      'image': 'assets/mint_tea.jpg',
      'price': 150,
    },

    // Signature Drinks
    {
      'title': 'HONEY\nCINNAMON LATTE',
      'category': 'Signature Drinks',
      'image': 'assets/honey.jpg',
      'price': 260,
    },
    {
      'title': 'SPICED\nCHAI LATTE',
      'category': 'Signature Drinks',
      'image': 'assets/spiced.jpg',
      'price': 240,
    },
    {
      'title': 'MATCHA\nLATTE',
      'category': 'Signature Drinks',
      'image': 'assets/matcha.jpg',
      'price': 250,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredCoffeeList = coffeeList
        .where((coffee) => (selectedCategory == 'Popular' ||
            coffee['category'] == selectedCategory))
        .toList();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchAndCategories(),
          const SizedBox(height: 8),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredCoffeeList.length,
                  itemBuilder: (context, index) {
                    final coffee = filteredCoffeeList[index];
                    return Column(
                      children: [
                        _buildCoffeeCard(
                          title: coffee['title']!,
                          category: coffee['category']!,
                          image: coffee['image'],
                          price: coffee['price'],
                          context: context,
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  }))
        ],
      ),
    );
  }

  Widget _buildSearchAndCategories() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFFEFE6DD),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBannerSection(),
          SizedBox(height: 16),
          Text(
            'What would you like to dring today?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategoryButton('Popular'),
                const SizedBox(width: 5),
                _buildCategoryButton('Black coffee'),
                const SizedBox(width: 5),
                _buildCategoryButton('Winter special'),
                const SizedBox(width: 5),
                _buildCategoryButton('Decaf'),
                const SizedBox(width: 5),
                _buildCategoryButton('Chocolate'),
                const SizedBox(width: 5),
                _buildCategoryButton('Herbal Tea'),
                const SizedBox(width: 5),
                _buildCategoryButton('Signature Drinks'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String label) {
    final bool isSelected = label == selectedCategory;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? const Color(0xFF2B1904) : const Color(0xFFFB8200),
        elevation: isSelected ? 6 : 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      ),
      onPressed: () {
        setState(() {
          selectedCategory = label;
        });
      },
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildBannerSection() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: const DecorationImage(
            image: AssetImage('assets/banner.png'),
            fit: BoxFit.cover,
          )),
    );
  }

  Widget _buildCoffeeCard({
    required String title,
    required String category,
    required String image,
    required BuildContext context,
    required int price,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Consumer<WishListProvider>(
        builder: (context, wishListProvider, child) {
          final isLiked = wishListProvider.isInWishList(title);
          return ListTile(
            leading: Image.asset(
              image,
              width: 100,
              height: 300,
              fit: BoxFit.cover,
            ),
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 4),
                Text(
                  '₹${price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: isLiked ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                final wishListItem = WishListItem(
                  title,
                  image,
                  category,
                  price,
                  likes: 0,
                );
                if (isLiked) {
                  wishListProvider.removeFromWishList(title);
                } else {
                  wishListProvider.addToWishList(wishListItem);
                }
              },
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Center(
                    child: Material(
                      color: Colors.transparent,
                      child: ItemDetailsPopup(
                        title: title,
                        category: category,
                        image: image,
                        price: price,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
