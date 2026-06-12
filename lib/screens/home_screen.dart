import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad/controller/cart_controller.dart';
import 'package:mad/data/shared_pref_manager.dart';
import 'package:mad/model/product.dart';
import 'package:mad/screens/product_detail_screen.dart';
import 'package:badges/badges.dart' as badges;
import 'package:mad/services/auth_service.dart';
import 'package:mad/services/product_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String fullName = "Guest";

  final CartController cartController = Get.put(CartController());

  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _loadFullName();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final products = await ProductService.instance.getProducts();
    setState(() {
      _products = products;
    });
  }

  Future<void> _loadFullName() async {
    User? user = await AuthService.instance.getCurrentUser();
    setState(() {
      fullName = user!.displayName ?? user.phoneNumber ?? user.email ?? fullName;
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
    final description = Padding(
      padding: EdgeInsets.only(left: 16),
      child: Text(
        "What do you want to read today?",
        style: TextStyle(fontSize: 14, color: Colors.black45),
      ),
    );

    List<Widget> productList = List.generate(_products.length, (i) {
      Product product = _products[i];

      return GestureDetector(
        child: Card(
          child: Image.network(
            "${product.image}",
            fit: BoxFit.cover,
            width: 160,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null)
                return child; // Image loaded completely
              return Image.asset(
                'assets/images/default-image-cover.jpg',
              ); // While loading
            },
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/default-image-cover.jpg',
              ); // If network fails
            },
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

    final newlyTitleRow = Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Newly",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Row(
            children: [
              Text(
                "Next",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Icon(Icons.navigate_next),
            ],
          ),
        ],
      ),
    );

    final popularRow = Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Popular",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Row(
            children: [
              Text(
                "Next",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Icon(Icons.navigate_next),
            ],
          ),
        ],
      ),
    );

    final searchWidget = Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: 'Search...',
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );

    List<String> menuArr = ["All", "ប្រលោមលោក", "បច្ចេកវិទ្យា", "សាសនា"];

    List<Widget> menuList = List.generate(menuArr.length, (i) {
      return Container(
        width: 100,
        child: TextButton(
          onPressed: () {

          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent),
          child: Text("${menuArr[i]}", style: TextStyle(color: Colors.white),),
        ),
      );
    });
    final menuListRow = SizedBox(
      height: 40,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: menuList,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: title,
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
            searchWidget,
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Category",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            menuListRow,
            newlyTitleRow,
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
