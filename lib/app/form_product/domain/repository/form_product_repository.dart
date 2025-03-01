import 'package:storeapp/app/core/domain/entity/product_entity.dart';

//no la pueden instanciar xq es abstracta
abstract class FormProductRepository {
  
  Future<bool> addProduct(ProductEntity productEntity);
  Future<ProductEntity> getProduct(String id);
}