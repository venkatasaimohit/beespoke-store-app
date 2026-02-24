import 'package:beespoke_store_app/screens/product_feed_screen.dart';
import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';
import 'package:beespoke_store_app/screens/liked_screen.dart';
import 'package:beespoke_store_app/screens/history_screen.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({super.key});

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  int index = 0;

  final screens = [
    ProductFeedScreen(),
    LikedScreen(),
    HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Liked"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
        ],
      ),
    );
  }
}