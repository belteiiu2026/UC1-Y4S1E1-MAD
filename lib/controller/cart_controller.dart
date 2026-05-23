import 'package:get/get.dart';
import 'package:mad/model/cart.dart';
import 'package:mad/services/cart_service.dart';

class CartController extends GetxController {

  var cartList = [].obs;

  @override
  void onInit() {
    super.onInit();
    // cartList = CartService.instance.getProductFromCart();
  }

  void addProductToCart(Cart cart){
    cartList.add(cart);
  }
}