import 'package:storeapp/app/core/domain/entity/product_entity.dart';

abstract class HomeRepository {
  List<ProductEntity> getProducts();
  bool deleteProduct(id);
}