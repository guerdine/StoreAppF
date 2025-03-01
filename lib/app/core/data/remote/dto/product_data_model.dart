import 'package:storeapp/app/core/domain/entity/product_entity.dart';

class ProductDataModel {
  final String id;
  late final String name;
  late final int price;
  late final String imageURL;

  ProductDataModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageURL,
  });

  //el json viene estructurtado de forma que tiene un id y ese id tiene un mapa de muchas caracteristicas
  //por eso se define asi, id y el mapa de caracteristicas de cada id
  ProductDataModel.fromJson(this.id, Map<String, dynamic> json) {
    name = json["name"];
    price = json["price"];
    imageURL = json["image"];
  }

  ProductEntity toEntity() {
    return ProductEntity(id: id, name: name, image: imageURL, price: price);
  }

  Map<String, dynamic> toJson(){
    return <String,dynamic>{
      "name" : name,
      "price" : price,
      "image" : imageURL
    };
  }
}
