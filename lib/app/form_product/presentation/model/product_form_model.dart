import 'package:storeapp/app/core/domain/entity/product_entity.dart';

class ProductFormModel {
  final String id;
  final String price;
  final String name;
  final String urlImage;

  ProductFormModel({
    required this.id,
    required this.price,
    required this.name,
    required this.urlImage,
  });

  ProductFormModel copyWith({
    String? id,
    String? price,
    String? name,
    String? urlImage,
  }) {
    return ProductFormModel(
      id: id ?? this.id,
      price: price ?? this.price,
      name: name ?? this.name,
      urlImage: urlImage ?? this.urlImage,
    );
  }

  ProductEntity toEntity() => ProductEntity(
    id: id,
    name: name,
    image: urlImage,
    price: int.parse(price),
  );
}
