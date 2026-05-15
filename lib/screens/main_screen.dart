import 'package:flutter/material.dart';
import 'package:mad/screens/account_screen.dart';
import 'package:mad/screens/cart_screen.dart';
import 'package:mad/screens/favorite_screen.dart';
import 'package:mad/screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _currentIndex = 0;

  List<Widget> listScreen = [
    HomeScreen(),
    FavoriteScreen(),
    CartScreen(),
    AccountScreen()
  ];

  @override
  Widget build(BuildContext context) {

    final bottomNavBarItems = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
      BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
      BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Account"),
    ];

    final bottomNavBar = BottomNavigationBar(
        fixedColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        items: bottomNavBarItems,
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
    );

    return Scaffold(
      body: listScreen.elementAt(_currentIndex),
      bottomNavigationBar: bottomNavBar ,
    );
  }
}
