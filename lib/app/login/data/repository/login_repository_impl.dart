import 'dart:math';

import 'package:storeapp/app/login/domain/entity/login_entity.dart';
import 'package:storeapp/app/login/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository{
  @override
  bool login(LoginEntity loginEntity) {
    return true;//Random().nextBool();//aqui si la cambio a true siempre hara login 
  }

}