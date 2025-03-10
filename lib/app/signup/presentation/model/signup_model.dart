import 'package:storeapp/app/core/domain/entity/user_entity.dart';

class SignupModel {
   final String id;
   final String name;
   final String email;
   final String password;
   final String image;
   SignupModel({
     required this.id,
     required this.name,
     required this.email,
     required this.password,
     required this.image,
   });
 
   SignupModel copyWith({
     String? id,
     String? name,
     String? email,
     String? password,
     String? image,
   }) {
     return SignupModel(
       id: id ?? this.id,
       name: name ?? this.name,
       email: email ?? this.email,
       password: password ?? this.password,
       image: image ?? this.image,
     );
   }
 
   UserEntity toEntity() => UserEntity(
     id: id,
     name: name,
     email: email,
     password: password,
     image: image
   );
 }