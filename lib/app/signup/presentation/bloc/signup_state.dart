import 'package:storeapp/app/signup/presentation/model/signup_model.dart';

sealed class SignupState {
   SignupState({required this.model});
 
   final SignupModel model;
 }
 
 final class InitialState extends SignupState {
   InitialState() : super(model: SignupModel(id: "", name: "", email: "", password: "", image: ""));
 }
 
 final class DataUpdateState extends SignupState {
   DataUpdateState({required super.model});
 }
 
 final class SubmitSuccessState extends SignupState {
   SubmitSuccessState({required super.model});
 }
 
 final class SubmitErrorState extends SignupState {
   SubmitErrorState({required super.model, required this.message});
   final String message;
 }