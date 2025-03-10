import 'package:storeapp/app/core/data/remote/dto/user_data_model.dart';
import 'package:storeapp/app/user_detail/presentation/model/user_model.dart';

final class UserEntity {
   final String id;
   final String name;
   final String email;
   final String image;
   final String password;
 
   UserEntity({
     required this.id,
     required this.name,
     required this.email,
     required this.image,
     required this.password,
   });
 
   UserModel toUserModel() {
     return UserModel(id: id, name: name, email: email, urlImage: image, password: password);
   }
 
   UserDataModel toUserDataModel() {
     return UserDataModel(id: id, name: name, email: email, imageUrl: image, password: password);
   }
 }