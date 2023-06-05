import 'dart:math';
import 'package:apl/API_4/Models/product_model.dart';
import 'package:apl/API_4/repository/api.dart';
import 'package:dio/src/response.dart' ;
import 'package:http/http.dart';

class ProductRepository{
  API api = API();

  // Future<List<Product>> fetchProduct() async {
  Future<Product> fetchProduct() async {
    try{
      var response = await api.sendRequest.get("/products");
      // List<dynamic> productMaps = response.data;
      Map<String, dynamic> productMaps = response.data as Map<String, dynamic> ;
      // return productMaps.map((product) => Product.fromJson(product)).toList();
      return Product.fromJson(productMaps);
    }
    catch(ex){
      throw ex;
    }
  }
}