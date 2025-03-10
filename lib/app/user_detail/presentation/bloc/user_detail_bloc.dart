import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/core/domain/use_case/logout_use_case.dart';
import 'package:storeapp/app/user_detail/domain/use_case/get_users_use_case.dart';
import 'package:storeapp/app/user_detail/presentation/bloc/user_detail_event.dart';
import 'package:storeapp/app/user_detail/presentation/bloc/user_detail_state.dart';
import 'package:storeapp/app/user_detail/presentation/model/user_model.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
   final GetUsersUseCase getUsersUseCase;
   final LogoutUseCase logoutUseCase;
 
   UserDetailBloc({
     required this.getUsersUseCase,
     required this.logoutUseCase,
   }) : super(UserLoadingState()) {
     on<GetUsersEvent>(_getUsersEvent);
     on<UserLogoutEvent>(_logoutEvent);
   }
 
   void _getUsersEvent(
     GetUsersEvent event,
     Emitter<UserDetailState> emit,
   ) async {
     late UserDetailState newState;
     try {
       newState = UserLoadingState();
       emit(newState);
 
       final List<UserModel> result = await getUsersUseCase.invoke();
 
       if (result.isEmpty) {
         newState = UserEmptyState();
       } else {
         newState = UserLoadDataState(model: state.model.copyWith(users: result));
       }
     } catch (e) {
       newState = UserHomeErrorState(
         model: state.model,
         message: "Error al obtener los usuarios",
       );
     }
 
     emit(newState);
   }
 
   void _logoutEvent(UserLogoutEvent event, Emitter<UserDetailState> emit) async {
     logoutUseCase.invoke();
 
     emit(UserLogoutState());
   }
 }