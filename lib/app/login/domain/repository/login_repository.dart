import 'package:storeapp/app/login/domain/entity/login_entity.dart';

//no la pueden instanciar xq es abstracta
abstract class LoginRepository {
  
  Future<bool> login(LoginEntity loginEntity);

}