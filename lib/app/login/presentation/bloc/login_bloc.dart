import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/login/domain/use_case/login_use_case.dart';
import 'package:storeapp/app/login/presentation/bloc/login_event.dart';
import 'package:storeapp/app/login/presentation/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
late final LoginUseCase _loginUseCase; 

  LoginBloc(): super((InitialState())){
    on<EmailChangedEvent>(_emailChangedEvent);
    on<PasswordChangedEvent>(_passwordChangedEvent);
    on<SubmitEvent>(_submitEvent);

    _loginUseCase = LoginUseCase();
  }

  FutureOr<void> _emailChangedEvent(EmailChangedEvent event, Emitter<LoginState> emit) {
    //final oldData = state.model; de esta forma se trabaja con la informacion previa, se define con el state.model
    //final newData = LoginFormModel(email: event.email, password: state.model.password);
    final newState = DataUpdateState(model: state.model.copyWith(email: event.email));
    emit(newState);
  }

  FutureOr<void> _passwordChangedEvent(PasswordChangedEvent event, Emitter<LoginState> emit) {
    final newState = DataUpdateState(model: state.model.copyWith(password: event.password));
    emit(newState);
  }

  FutureOr<void> _submitEvent(SubmitEvent event, Emitter<LoginState> emit) {
    final bool result = _loginUseCase.invoke(state.model);
    late final LoginState newState;
    if(result){
      newState = LoginSuccessState(model: state.model);
    }else{
      newState = LoginErrorState(model: state.model, message : "Error al iniciar sesion");
    }
    emit(newState);
  }
}