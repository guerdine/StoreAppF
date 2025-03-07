import 'package:dio/dio.dart';
import 'package:storeapp/app/core/data/remote/dto/product_data_model.dart';

final class ProductService {
  final Dio dio;
  final String _baseURL =
      "https://storeapp-77c7c-default-rtdb.firebaseio.com";

  ProductService({required this.dio});

  Future<List<ProductDataModel>> getAll() async {
    final List<ProductDataModel> products = [];

    try {
      final Response<Map> response = await dio.get("$_baseURL/products.json");

      if (response.data != null) {
        response.data?.forEach((key, value) {
          products.add(ProductDataModel.fromJson(key, value));
        });
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
    return products;
  }

  Future<bool> delete(String id) async {
    try {
      await dio.delete("$_baseURL/products/$id.json");
    } catch (e) {
      throw Exception("Error: $e");
    }
    return true;
  }

    Future<bool> add(ProductDataModel product) async {
    try {
      await dio.post("$_baseURL/products.json",data: product.toJson());
    } catch (e) {
      throw Exception("Error: $e");
    }
    return true;
  }


  Future<ProductDataModel> get(String id) async {
    late final ProductDataModel product;
    try {
      final Response<Map<String, dynamic>> response = await dio.get("$_baseURL/products/$id.json");

      if (response.data != null) {
          product = ProductDataModel.fromJson(id, response.data!);
      }
    } catch (e) {
      throw (Exception(e));
    }
    return product;
  }

  Future<bool> update(productDataModel) async {
    try {
      await dio.patch("$_baseURL/products/${productDataModel.id}.json", data : productDataModel.toJson());
    } catch (e) {
      throw(Exception(e));
    }
    return true;
  }
}
