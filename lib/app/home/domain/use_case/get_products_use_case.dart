import 'package:storeapp/app/home/domain/repository/home_repository.dart';
import 'package:storeapp/app/home/presentation/model/product_model.dart';

class GetProductsUseCase {
  final HomeRepository homeRepository;

  GetProductsUseCase({required this.homeRepository});

  List<ProductModel> invoke(){
     final List<ProductModel> products = [
      /*ProductModel(
        id: "id",
        name: "Pedido Sorpresa",
        urlIamage:
            "https://cdn3d.iconscout.com/3d/premium/thumb/producto-5806313-4863042.png",
        price: 1234,
      ),*/
    ];
    final result = homeRepository.getProducts();
    for (var element in result) {
      products.add(element.toProductModel());
    }
    return products;
  }

}