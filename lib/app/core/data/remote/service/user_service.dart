import 'package:dio/dio.dart';
import 'package:storeapp/app/core/data/remote/dto/user_data_model.dart';

final class UserService {
   final Dio dio;
   final String _baseUrl =
       "https://storeapp-77c7c-default-rtdb.firebaseio.com";
 
   UserService({required this.dio});
 
   Future<List<UserDataModel>> getAll() async {
     final List<UserDataModel> users = [];
 
     try {
       final Response<Map> response = await dio.get("$_baseUrl/users.json");
 
       if (response.data != null) {
         response.data?.forEach((key, value) {
           users.add(UserDataModel.fromJson(key, value));
         });
       }
     } catch (e) {
       throw Exception("Error: $e");
     }
 
     return users;
   }
 
   Future<bool> add(UserDataModel product) async {
     try {
       await dio.post("$_baseUrl/users.json", data: product.toJson());
     } catch (e) {
       throw (Exception(e));
     }
     return true;
   }
 
   Future<UserDataModel> get(String id) async {
     late final UserDataModel user;
     try {
       final Response<Map<String, dynamic>> response = await dio.get(
         "$_baseUrl/users/$id.json",
       );
       if (response.data != null) {
         user = UserDataModel.fromJson(id, response.data!);
       }
     } catch (e) {
       throw (Exception(e));
     }
     return user;
   }

 }