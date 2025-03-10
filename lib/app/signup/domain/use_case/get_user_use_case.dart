
 import 'package:storeapp/app/core/domain/entity/user_entity.dart';
import 'package:storeapp/app/signup/domain/repository/signup_repository.dart';
import 'package:storeapp/app/signup/presentation/model/signup_model.dart';

class GetUserUseCase {
   final SignupRepository signupRepository;
 
   GetUserUseCase({required this.signupRepository});
 
   Future<SignupModel> invoke(String id) async {
     try {
       final UserEntity data = await signupRepository.getUser(id);
 
       return SignupModel(
         id: id,
         name: data.name,
         email: data.email,
         password: data.password,
         image: data.image,
       );
     } catch (e) {
       throw (Exception());
     }
   }
 }