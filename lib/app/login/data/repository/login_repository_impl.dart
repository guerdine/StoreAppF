
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/app/login/domain/entity/login_entity.dart';
import 'package:storeapp/app/login/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository{
  @override
  Future<bool> login(LoginEntity loginEntity) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("login", true);
    return true;//Random().nextBool();//aqui si la cambio a true siempre hara login 
  }

}