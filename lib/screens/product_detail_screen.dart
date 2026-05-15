import 'package:flutter/material.dart';
import 'package:mad/model/cart.dart';
import 'package:mad/services/cart_service.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {


  Future<void> _addProductToCart() async {

    final cart = Cart(
      productId: 1,
      price: 2000,
      qty: 1,
      discount: 0
    );
    await CartService.instance.insertProductToCart(cart);
    print("Insert success");
  }

  @override
  Widget build(BuildContext context) {
    final addToCartButton = Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0997A4)),
          onPressed: _addProductToCart,
          child: Text("Add To Cart", style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text("Product Detail"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/book1.png",
                      fit: BoxFit.cover,
                      height: 300,
                    ),
                  ),
                ],
              ),
            ),
            addToCartButton,
          ],
        ),
      ),
    );
  }
}
