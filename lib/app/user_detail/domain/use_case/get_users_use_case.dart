import 'package:storeapp/app/user_detail/domain/repository/user_detail_repository.dart';
import 'package:storeapp/app/user_detail/presentation/model/user_model.dart';

class GetUsersUseCase {
   final UserDetailRepository homeAccountRepository;
 
   GetUsersUseCase({required this.homeAccountRepository});
 
   Future <List<UserModel>> invoke() async{
     final List<UserModel> users = [];
 
     try {
         final result = await homeAccountRepository.getUsers();
     for (var element in result) {
       users.add(element.toUserModel());
     }  
     } catch (e) {
       throw(Exception(e));
     }
 
     return users;
   }
 }