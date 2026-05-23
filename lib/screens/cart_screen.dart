import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad/controller/cart_controller.dart';
import 'package:mad/model/cart.dart';
import 'package:mad/services/cart_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController cartController = Get.put(CartController());

  bool _isLoading = true;
  String _errorMessage = "No Data";
  List<Cart> orderList = [];

  @override
  void initState() {
    super.initState();
    _loadDataFromServer();
  }

  Future<void> _loadDataFromServer() async {
    await CartService.instance
        .getProductFromCart()
        .then((List<Cart> orders) {
          setState(() {
            orderList = orders;
            _isLoading = false;
          });
        })
        .catchError((error) {
          setState(() {
            _isLoading = false;
            _errorMessage = error;
          });
        });
  }

  bool isShipping = true;

  double _calculateSubTotal() {
    return orderList.length * 2;
  }

  double _calculateVat() {
    return (orderList.length * 2) * (10 / 100);
  }

  double _calculateTotal() {
    return _calculateSubTotal() + _calculateVat() + (isShipping ? 5 : 0);
  }

  @override
  Widget build(BuildContext context) {

    // dynamic orderListWidget = cartController.cartList.value.map((m) {
    //   return SizedBox(
    //     child: Dismissible(
    //       background: Container(color: Colors.redAccent),
    //       key: ValueKey<int>(m.id!),
    //       onDismissed: (DismissDirection direction) {
    //         CartService.instance.removeProductFromCart(m.id!);
    //       },
    //       child: Row(
    //         children: [
    //           Image.asset("assets/images/book2.png", width: 50, height: 100),
    //           Expanded(
    //             child: Column(
    //               children: [
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text("${m.productId}", style: TextStyle(fontSize: 18)),
    //                     Icon(Icons.delete, color: Colors.red, size: 18),
    //                   ],
    //                 ),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text("2\$"),
    //                     Row(
    //                       children: [
    //                         Padding(
    //                           padding: EdgeInsets.only(right: 8),
    //                           child: IconButton(
    //                             onPressed: () {},
    //                             icon: Icon(Icons.add_circle_outline, size: 16),
    //                           ),
    //                         ),
    //                         Text("1", style: TextStyle(fontSize: 18)),
    //                         Padding(
    //                           padding: EdgeInsets.only(left: 8),
    //                           child: IconButton(
    //                             onPressed: () {},
    //                             icon: Icon(
    //                               Icons.remove_circle_outline,
    //                               size: 16,
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //                 Divider(),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }).toList();
    //
    // final subTotal = SizedBox(
    //   child: Padding(
    //     padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [Text("Sub-Total"), Text("\$ ${_calculateSubTotal()}")],
    //     ),
    //   ),
    // );
    //
    // orderListWidget.add(subTotal);
    //
    // final vat = SizedBox(
    //   child: Padding(
    //     padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [Text("VAT (%)"), Text("\$ ${_calculateVat()}")],
    //     ),
    //   ),
    // );
    //
    // orderListWidget.add(vat);
    //
    // final shippingFee = SizedBox(
    //   child: Padding(
    //     padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [Text("Shipping Fee"), Text("\$ ${isShipping ? 5 : 0}")],
    //     ),
    //   ),
    // );
    //
    // orderListWidget.add(shippingFee);
    //
    // final total = SizedBox(
    //   child: Padding(
    //     padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Text(
    //           "Total",
    //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //         ),
    //         Text(
    //           "\$ ${_calculateTotal()}",
    //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    //
    // orderListWidget.add(SizedBox(child: Divider()));
    // orderListWidget.add(total);
    //
    // final checkoutBtn = SizedBox(
    //   child: Padding(
    //     padding: EdgeInsets.only(left: 8, right: 8, bottom: 16),
    //     child: SizedBox(
    //       height: 50,
    //       width: MediaQuery.of(context).size.width,
    //       child: ElevatedButton(
    //         style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
    //         onPressed: () {},
    //         child: Text("Checkout", style: TextStyle(color: Colors.white)),
    //       ),
    //     ),
    //   ),
    // );

    // return Scaffold(
    //   appBar: AppBar(elevation: 3, title: Text("Cart"), centerTitle: true),
    //   body: SafeArea(
    //     child: _isLoading
    //         ? Center(child: CircularProgressIndicator())
    //         : orderList.length == 0
    //         ? Center(child: Text("${_errorMessage}"))
    //         : Column(
    //       children: [
    //         Expanded(
    //           child: SizedBox(child: ListView(children: orderListWidget)),
    //         ),
    //         checkoutBtn,
    //       ],
    //     ),
    //   ),
    // );

    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: SafeArea(
        child: Center(
          child: Obx(() => Text("Data ${cartController.cartList.value.length}")),
        ),
      ),
    );
  }

  //
  // return Scaffold(
  //   appBar: AppBar(title: Text("Cart"), elevation: 2, centerTitle: true),
  //   body: SafeArea(
  //     child: FutureBuilder(
  //       future: CartService.instance.getProductFromCart(),
  //       builder: (BuildContext context, AsyncSnapshot<List<Cart>> snapshot) {
  //         if (snapshot.connectionState != ConnectionState.done) {
  //           return Center(child: CircularProgressIndicator());
  //         }
  //
  //         if (snapshot.hasError) {
  //           return Center(child: Text("${snapshot.error}"));
  //         }
  //
  //         if (!snapshot.hasData) {
  //           return Center(child: Text("No Data"));
  //         }
  //
  //         List<Cart> carts = snapshot.data as List<Cart>;
  //         return ListView.separated(
  //           itemCount: carts.length,
  //           itemBuilder: (BuildContext context, int index) {
  //             Cart cart = carts[index];
  //             return Dismissible(
  //               key: ValueKey(index),
  //               background: Container(
  //                   color: Colors.red,
  //               ),
  //               child: ListTile(
  //                 leading: Image.asset(
  //                   "assets/images/book1.png",
  //                   fit: BoxFit.cover,
  //                   width: 100,
  //                 ),
  //                 title: Text("${cart.productId}"),
  //                 subtitle: Text("${cart.price}"),
  //               ),
  //               onDismissed: (DismissDirection direction){
  //                 CartService.instance.removeProductFromCart(cart.id!);
  //               },
  //             );
  //           },
  //           separatorBuilder: (BuildContext context, int index) {
  //             return Divider();
  //           },
  //         );
  //       },
  //     ),
  //   ),
  // );
  // }
}
