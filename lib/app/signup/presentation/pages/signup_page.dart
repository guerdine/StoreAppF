import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Pagina de registro", style: TextStyle(fontSize: 48.0)),

/*
nombre del usuario
correo
pasuor 2 veces para validarla
url de imagen
botoncito de crear usuario 
*/

            OutlinedButton(
              //onPressed: () => context.pop(), ambos son validos
              onPressed: () => GoRouter.of(context).pop(),
              child: SizedBox(
                width: double.infinity,
                child: Text("Navegar al login", textAlign: TextAlign.center),
              ),
            )
          ],
        ),
      ),
    );
  }
}
