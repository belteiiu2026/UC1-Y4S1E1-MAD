import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mad/model/product.dart';

class ProductService {

  static final ProductService instance = ProductService._init();

  ProductService._init();

  Future<List<Product>> getProducts() async{

     String token = "ABC";

     String apiUrl = "https://fakestoreapi.com/products";
     final headers = {
       "Content-Type":"application/json",
       "Authorization": "$token"
     };
     // Http
     //final response = await http.get(Uri.parse(apiUrl), headers: headers);
     // Dio
     final dio = Dio();
     final response = await dio.get(apiUrl, options: Options(headers: headers));
     if(response.statusCode == 200){
       // Http
       // final data = jsonDecode(response.body) as List<dynamic>;
       // Dio
       final data = response.data as List<dynamic>;
       List<Product> products = data.map((p){
         return Product.fromJson(p);
       }).toList();
       return products;
     }else{
       print("Error Code : ${response.statusCode}");
       throw("Internal Server Error");
     }
  }


}