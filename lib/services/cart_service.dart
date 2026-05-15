
import 'package:mad/data/db_manager.dart';
import 'package:mad/model/cart.dart';

class CartService {

  String tableName = "carts";

  static final CartService instance = CartService._init();

  CartService._init();

  Future<void> insertProductToCart(Cart cart) async{
    final db = await DBManager.instance.database;
    await db.insert(tableName, cart.toMap());
  }

  Future<List<Cart>> getProductFromCart() async {
    final db = await DBManager.instance.database;
    List<Map<String,dynamic>> results = await db.query(tableName);
    return List.generate(results.length,(i) => Cart.fromMap(results[i])).toList();
  }

  Future<void> removeProductFromCart(int id) async{
    final db = await DBManager.instance.database;
    await db.delete(tableName, where: "id=?" , whereArgs: [id]);
  }
}