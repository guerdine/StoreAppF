import 'package:storeapp/app/home/presentation/model/product_model.dart';

final class ProductEntity {
  final String id;
  final String name;
  final String image;
  final int price;

  ProductEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  ProductModel toProductModel() {
    return ProductModel(
      id: id,
      name: name,
      urlImage:
          "https://cdn3d.iconscout.com/3d/premium/thumb/producto-5806313-4863042.png",
      price: price,
    );
  }
}
