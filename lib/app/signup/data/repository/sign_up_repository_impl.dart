import 'package:storeapp/app/core/data/remote/service/user_service.dart';
import 'package:storeapp/app/core/domain/entity/user_entity.dart';
import 'package:storeapp/app/signup/domain/repository/signup_repository.dart';

class SignupRepositoryImpl implements SignupRepository {
   final UserService userService;
 
   SignupRepositoryImpl({required this.userService});
   @override
   Future<bool> addUser(UserEntity userEntity) {
     try {
       return userService.add(userEntity.toUserDataModel());
     } catch (e) {
       throw (Exception());
     }
   }
 
   @override
   Future<UserEntity> getUser(String id) async {
     try {
       final response = await userService.get(id);
       return response.toEntity();
     } catch (e) {
       throw (Exception());
     }
   }
   
 }