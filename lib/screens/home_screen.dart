import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad/controller/cart_controller.dart';
import 'package:mad/data/shared_pref_manager.dart';
import 'package:mad/screens/product_detail_screen.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String fullName = "Guest";

  final CartController cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    _loadFullName();
  }

  Future<void> _loadFullName() async {
    String? _fullName = await SharedPrefManager.instance.getPref("fullName");
    setState(() {
      fullName = _fullName;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartWidget = badges.Badge(
      badgeContent: Obx(() => Text("${cartController.cartList.value.length}")),
      child: Icon(Icons.shopping_cart),
    );

    final title = Text(
      "Hello, $fullName",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
        color: Colors.red,
      ),
    );
    final description = Text(
      "What do you want to read today?",
      style: TextStyle(fontSize: 14, color: Colors.black45),
    );

    List<Widget> productList = List.generate(10, (i) {
      return GestureDetector(
        child: Card(
          child: Image.asset(
            "assets/images/book1.png",
            fit: BoxFit.cover,
            width: 160,
          ),
        ),
        onTap: () {
          final route = MaterialPageRoute(
            builder: (BuildContext context) => ProductDetailScreen(),
          );
          Navigator.push(context, route);
        },
      );
    }).toList();

    final popularRow = Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Popular",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          Row(
            children: [
              Text(
                "Next",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              Icon(Icons.navigate_next),
            ],
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: title,
        backgroundColor: Colors.white,
        actions: [
          cartWidget,
          Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Icon(Icons.notifications),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            description,
            SizedBox(
              height: 200,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: productList),
              ),
            ),
            popularRow,
            SizedBox(
              height: 200,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: productList),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
