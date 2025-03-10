import 'package:storeapp/app/core/data/remote/service/user_service.dart';
import 'package:storeapp/app/core/domain/entity/user_entity.dart';
import 'package:storeapp/app/user_detail/domain/repository/user_detail_repository.dart';

class UserDetailRepositoryImpl implements UserDetailRepository {
   final UserService userService;
 
   UserDetailRepositoryImpl({required this.userService});
 
   @override
   Future<List<UserEntity>> getUsers() async {
     final List<UserEntity> users = [];
 
     try {
       final response = await userService.getAll();
       for (var element in response) {
         users.add(element.toEntity());
       }
     } catch (e) {
       throw (Exception(e));
     }
 
     return users;
   }
 }