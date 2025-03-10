import 'package:storeapp/app/core/domain/entity/user_entity.dart';

class UserDataModel {
   final String id;
   late final String name;
   late final String email;
   late final String password;
   late final String imageUrl;
 
   UserDataModel({
     required this.id,
     required this.name,
     required this.email,
     required this.password,
     required this.imageUrl,
   });
 
   UserDataModel.fromJson(this.id, Map<String, dynamic> json) {
     name = json["name"];
     email = json["email"];
     password = json["password"];
     imageUrl = json["image"];
   }
 
   UserEntity toEntity() {
     return UserEntity(id: id, name: name, email:email, image: imageUrl, password: password);
   }
 
   Map<String, dynamic> toJson() {
     return <String, dynamic>{
       "name":name,
       "email":email,
       "password":password,
       "image":imageUrl,
     };
   }
 }