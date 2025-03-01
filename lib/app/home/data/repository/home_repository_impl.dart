import 'package:storeapp/app/core/domain/entity/product_entity.dart';
import 'package:storeapp/app/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  bool deleteProduct(id) {
    // TODO: implement deleteProduct
    return false;
  }

  @override
  List<ProductEntity> getProducts() {
    // TODO: implement getProducts
    return [
      ProductEntity(
        id: "123",
        name: "Producto Sorpresa",
        image:
            "https://cdn3d.iconscout.com/3d/premium/thumb/producto-5806313-4863042.png",
        price: 123000,
      ),
    ];
  }
}
