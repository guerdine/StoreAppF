import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [HeaderLoginWidget(), BodyLoginWidget(), FooterLoginWidget()],
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
  BodyLoginWidget({super.key});

  @override
  State<BodyLoginWidget> createState() => _BodyLoginWidgetState();
}

class _BodyLoginWidgetState extends State<BodyLoginWidget> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(
          right: 32.0,
          left: 32.0,
          top: 80.0,
        ), //margenes para separar del borde de la pantalla y mapea en der e izq
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "email:",
                icon: Icon(Icons.person),
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
            ), //pasuor
            SizedBox(height: 40.0),
            FilledButton(
              onPressed: () => {},
              child: SizedBox(
                width: double.infinity,
                child: Text("Iniciar sesion", textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
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
