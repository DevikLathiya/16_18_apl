import 'package:apl/API_4/Shop_cubit/shop_state.dart';
import 'package:apl/API_4/repository/product_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Models/product_model.dart';

class ShopingAuth extends Cubit<ShopingState> {
  final dio = Dio();
  ShopingAuth() : super(ShopingInitState());

  ProductRepository productRepository = ProductRepository();
  Product? product;
  void request() async {
    try
    {
      emit(ShopingLodingState()) ;
      // List<Product> product = await productRepository.fetchProduct();
       product = await productRepository.fetchProduct();
     // emit(ShopingLoddedState(product));
    }
    catch(e)
    {
      emit(ShopingErrorState(e.toString()));
    }

}
}