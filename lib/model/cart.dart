
class Cart {

  int? id;
  int? productId;
  int? qty;
  double? price;
  int? discount;

  Cart({this.id, this.productId, this.qty, this.price, this.discount});


  Map<String,dynamic> toMap() => {
    "id": id,
    "product_id": productId,
    "qty" : qty,
    "price": price,
    "discount" : discount
  };

  factory Cart.fromMap(Map<String,dynamic> map) => Cart(
    id: map["id"],
    productId: map["product_id"],
    qty: map["qty"],
    price: map["price"],
    discount: map["discount"]
  );
}