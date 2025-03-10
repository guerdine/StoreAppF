import 'package:storeapp/app/user_detail/presentation/model/user_detail_model.dart';

sealed class UserDetailState {
   UserDetailState({required this.model});
 
   final UserDetailModel model;
 }
 
 final class UserEmptyState extends UserDetailState {
   UserEmptyState() : super(model: UserDetailModel(users: []));
 }
 
 final class UserLoadingState extends UserDetailState {
   final String message;
   UserLoadingState({this.message = "Cargando Usuarios..."})
     : super(model: UserDetailModel(users : []));
 }
 
 final class UserLoadDataState extends UserDetailState {
   UserLoadDataState({required super.model});
 }
 
 final class UserHomeErrorState extends UserDetailState {
   UserHomeErrorState({required super.model, required this.message});
   final String message;
 }
 
 
 final class UserLogoutState extends UserDetailState {
   UserLogoutState() : super(model: UserDetailModel(users: []));
 }