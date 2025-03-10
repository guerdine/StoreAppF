import 'package:storeapp/app/core/domain/entity/user_entity.dart';
import 'package:storeapp/app/signup/domain/repository/signup_repository.dart';
import 'package:storeapp/app/signup/presentation/model/signup_model.dart';

class AddUserUseCase {
   final SignupRepository signupRepository;
 
   AddUserUseCase({required this.signupRepository});
 
   Future<bool> invoke(SignupModel signupModel) {
     try {
       final UserEntity data = signupModel.toEntity();
 
       return signupRepository.addUser(data);
     } catch (e) {
       throw (Exception());
     }
   }
 }