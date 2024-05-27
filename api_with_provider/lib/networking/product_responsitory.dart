// ignore_for_file: dead_code

import 'package:dio/dio.dart';

import 'products_model.dart';

class ProductRepository {
  Future<List<Product>> getProduct(Dio dio) async {
    try {
      final Response response =
          await dio.get('https://651920eb818c4e98ac6012ef.mockapi.io/product');
      final value = response.data;
      return productsFromJson(value);
    } catch (e) {
      return [];
    }
  }

  Future<Product> getProductDetail(String id) async {
    await Future.delayed(const Duration(seconds: 2));
    return Product(id: id, name: "Laptop");
  }
}
