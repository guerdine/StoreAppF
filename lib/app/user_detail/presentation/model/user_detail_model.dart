import 'package:storeapp/app/user_detail/presentation/model/user_model.dart';

class UserDetailModel {
   final List<UserModel> users;
 
   UserDetailModel({required this.users});
 
   UserDetailModel copyWith({List<UserModel>? users}) {
     return UserDetailModel(users: users ?? this.users);
   }
 }