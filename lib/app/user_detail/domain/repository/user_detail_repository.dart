
 import 'package:storeapp/app/core/domain/entity/user_entity.dart';

abstract class UserDetailRepository {
   Future <List<UserEntity>> getUsers();
 }