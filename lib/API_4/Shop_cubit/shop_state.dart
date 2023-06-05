import '../Models/product_model.dart';

abstract class ShopingState {}

class ShopingInitState extends ShopingState {}

class ShopingLodingState extends ShopingState {}

class ShopingLoddedState extends ShopingState {
  final List<Product> product;
  ShopingLoddedState(this.product);
}

class ShopingErrorState extends ShopingState {
  final String error;
  ShopingErrorState(this.error);
}