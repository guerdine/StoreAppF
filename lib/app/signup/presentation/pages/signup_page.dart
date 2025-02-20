import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});
  /*
nombre del usuario
correo
pasuor 2 veces para validarla
url de imagen
botoncito de crear usuario 
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SignUpHeaderWidget(),
          SignUpBodyWidget(),
          SignUpFooterWidget(),
        ],
      ),
    );
  }
}

class SignUpFooterWidget extends StatelessWidget {
  const SignUpFooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          right: 32.0,
          left: 32.0,
          top: 30.0,
        ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () => {},
              child: SizedBox(
                child: Text("Iniciar sesion", textAlign: TextAlign.center),
              ),
            ),
            SizedBox(width: 16.0),
            OutlinedButton(
              //onPressed: () => context.pop(), ambos son validos
              onPressed: () => GoRouter.of(context).pop(),
              child: SizedBox(
                child: Text("Navegar al login", textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpBodyWidget extends StatefulWidget {
  const SignUpBodyWidget({super.key});

  @override
  State<SignUpBodyWidget> createState() => _SignUpBodyWidgetState();
}

class _SignUpBodyWidgetState extends State<SignUpBodyWidget> {
  bool showPassword = false;
  bool showConfirmPassword = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          right: 32.0,
          left: 32.0,
          top: 30.0,
        ),
      child: Column(
        children: [
          Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/3/3a/Cat03.jpg",
            width: double.infinity,
            height: 100.0,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              labelText: "Nombre:",
              icon: Icon(Icons.person),
              hintText: "Escriba su nombre",
            ),
            keyboardType: TextInputType.name,
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              labelText: "email:",
              icon: Icon(Icons.email),
              hintText: "Escriba su email",
            ),
            keyboardType: TextInputType.emailAddress,
          ), //email
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              labelText: "pasuor:",
              icon: Icon(Icons.lock),
              hintText: "Escriba su password",
              suffixIcon: GestureDetector(
                onTap:
                    () => setState(() {
                      showPassword = !showPassword;
                    }),
                child: Icon(
                  showPassword ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            obscureText: !showPassword,
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              labelText: "Confirma la pasuor:",
              icon: Icon(Icons.lock),
              hintText: "Escriba su password",
              suffixIcon: GestureDetector(
                onTap:
                    () => setState(() {
                      showConfirmPassword = !showConfirmPassword;
                    }),
                child: Icon(
                  showConfirmPassword ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            obscureText: !showConfirmPassword,
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              labelText: "URL de imagen:",
              icon: Icon(Icons.image),
              hintText: "Digita el enlace de tu imagen",
            ),
            keyboardType: TextInputType.url,
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

class SignUpHeaderWidget extends StatelessWidget {
  const SignUpHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          right: 32.0,
          left: 32.0,
          top: 10.0,
        ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("Pagina de registro", style: TextStyle(fontSize: 48.0))],
      ),
    );
  }
}
