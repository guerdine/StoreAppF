
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
import 'package:storeapp/app/signup/presentation/bloc/signup_bloc.dart';
import 'package:storeapp/app/signup/presentation/bloc/signup_event.dart';
import 'package:storeapp/app/signup/presentation/bloc/signup_state.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: DependencyInjection.serviceLocator.get<SignupBloc>(),
      child: Scaffold(resizeToAvoidBottomInset: false, body: SignupLogin()),
    );
  }
}

class SignupLogin extends StatelessWidget {
  const SignupLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25.0),
          padding: const EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SignUpRegistro(),
        ),
      ),
    );
  }
}

class SignUpRegistro extends StatefulWidget {
  const SignUpRegistro({super.key});

  @override
  State<SignUpRegistro> createState() => _SignUpRegistroState();
}

class _SignUpRegistroState extends State<SignUpRegistro> {
  String urlImagen = '';
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignupBloc>();
    TextEditingController nameUserField = TextEditingController();
    TextEditingController emailUserField = TextEditingController();
    TextEditingController passwordUserField = TextEditingController();
    TextEditingController imageUserField = TextEditingController();

    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        switch (state) {
          case InitialState() || DataUpdateState():
            break;
          case SubmitSuccessState():
            GoRouter.of(context).pop();
            break;
          case SubmitErrorState():
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
      child: BlocBuilder<SignupBloc, SignupState>(
        builder: (context, state) {
          nameUserField.text = state.model.name;
          emailUserField.text = state.model.email;
          passwordUserField.text = state.model.password;
          imageUserField.text = state.model.image;

          return Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 70.0,
                  backgroundImage: NetworkImage(urlImagen),
                ),
                SizedBox(height: 40.0),
                TextFormField(
                  controller: nameUserField,
                  onChanged:
                      (value) => bloc.add(UserNameChangedEvent(name: value)),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: "Usuario:",
                    icon: Icon(Icons.person_rounded),
                    hintText: "Escriba su usuario",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 30.0),
                TextFormField(
                  controller: emailUserField,
                  onChanged:
                      (value) => bloc.add(UserEmailChangedEvent(email: value)),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: "Email:",
                    icon: Icon(Icons.email_outlined),
                    hintText: "Escriba su email",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 30.0),
                TextFormField(
                  controller: passwordUserField,
                  onChanged:
                      (value) =>
                          bloc.add(UserPasswordChangedEvent(password: value)),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Contraseña:",
                    icon: Icon(Icons.lock),
                    hintText: "Escriba su contraseña",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 30.0),
                TextFormField(
                  controller: imageUserField,
                  onChanged: (value) {
                    bloc.add(UserUrlImageChangedEvent(image: value));
                    setState(() {
                      urlImagen = value;
                    });
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: "Imagen:",
                    icon: Icon(Icons.image),
                    hintText: "Ingrese la URL de imagen",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 30.0),
                FilledButton(
                  onPressed: () => {bloc.add(UserSubmitEvent())},
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text("Registrarse", textAlign: TextAlign.center),
                  ),
                ),
                SizedBox(height: 30.0),
                GestureDetector(
                  child: Text(
                    "Ya tengo una Cuenta",
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue,
                    ),
                  ),
                  onTap: () => GoRouter.of(context).pushNamed("login"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}