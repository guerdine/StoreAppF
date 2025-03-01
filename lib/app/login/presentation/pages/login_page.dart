import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
import 'package:storeapp/app/login/presentation/bloc/login_bloc.dart';
import 'package:storeapp/app/login/presentation/bloc/login_event.dart';
import 'package:storeapp/app/login/presentation/bloc/login_state.dart';
import 'package:storeapp/app/login/presentation/pages/login_mixin.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: DependencyInjection.serviceLocator.get<LoginBloc>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            HeaderLoginWidget(),
            BodyLoginWidget(),
            FooterLoginWidget(),
          ],
        ),
      ),
    );
  }
}

class FooterLoginWidget extends StatelessWidget {
  const FooterLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //color: Colors.amber,
      height: 100.0,
      child: Column(
        children: [
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Aun no tienes cuenta?"),
              SizedBox(width: 32.0),
              GestureDetector(
                //onTap: () => context.go('/sign-up'),
                onTap: () => {GoRouter.of(context).pushNamed("sign-up")},
                child: Text(
                  "Registrate aqui!",
                  style: TextStyle(
                    color: Colors.purple,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.purple,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BodyLoginWidget extends StatefulWidget {
  const BodyLoginWidget({super.key});

  @override
  State<BodyLoginWidget> createState() => _BodyLoginWidgetState();
}

class _BodyLoginWidgetState extends State<BodyLoginWidget> with LoginMixin {
  bool _showPassword = false;
  Timer? _autoShowTimer;
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        switch (state) {
          case InitialState() || DataUpdateState():
            break;
          case LoginSuccessState():
            GoRouter.of(context).pushReplacementNamed("home");
            break;
          case LoginErrorState():
            showDialog(
              context: context,
              builder:
                  (BuildContext context) => AlertDialog(
                    title: const Text('Error'),
                    content: Text(state.message),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );
            break;
          }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final bool isValidForm =
              validateEmail(state.model.email) == null &&
              validatePassword(state.model.password) == null;
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(
                right: 32.0,
                left: 32.0,
                top: 80.0,
              ), //margenes para separar del borde de la pantalla y mapea en der e izq
              child: Form(
                key: keyForm,
                child: Column(
                  children: [
                    Text(state.model.email),
                    Text(state.model.password),
                    TextFormField(
                      onChanged:
                          (value) => setState(() {
                            bloc.add(EmailChangedEvent(email: value));
                          }),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: validateEmail,
                      decoration: InputDecoration(
                        labelText: "email:",
                        icon: Icon(Icons.email),
                        hintText: "Escriba su email",
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ), //email
                    SizedBox(height: 16.0),
                    TextFormField(
                      onChanged:
                          (value) => setState(() {
                            bloc.add(PasswordChangedEvent(password: value));
                          }),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: validatePassword,
                      decoration: InputDecoration(
                        labelText: "pasuor:",
                        icon: Icon(Icons.lock),
                        hintText: "Escriba su password",
                        ////aplicar cambios para el registro
                        suffixIcon: InkWell(
                          onTap: () {
                            _autoShowTimer
                                ?.cancel(); //solamente en el caso de que NO sea nulo
                            if (!_showPassword) {
                              _autoShowTimer = Timer(
                                Duration(seconds: 3),
                                () => setState(() {
                                  _showPassword = false;
                                }),
                              );
                            }
                            setState(() {
                              _showPassword = !_showPassword;
                              /*Future.delayed( Duration(seconds: 3), () => setState(() {
                              _showPassword = false;
                            }));*/
                            });
                          },
                          child: Icon(
                            _showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      obscureText: !_showPassword,
                    ), //pasuor
                    SizedBox(height: 40.0),
                    FilledButton(
                      onPressed:
                          isValidForm ? () => {bloc.add(SubmitEvent())} : null,
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Iniciar sesion",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class HeaderLoginWidget extends StatelessWidget {
  const HeaderLoginWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //color : Colors.blueGrey,
      height: 140.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/3/3a/Cat03.jpg",
            width: double.infinity,
            height: 100.0,
            fit: BoxFit.contain,
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              "Inicio de sesion",
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
