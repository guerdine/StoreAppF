import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HomePageHeaderWidget(),
          Container(
            margin: EdgeInsets.only(right: 32.0, left: 32.0, top: 30.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    //onPressed: () => context.pop(), ambos son validos
                    onPressed: () => GoRouter.of(context).pushReplacementNamed("login"),
                    child: SizedBox(
                      child: Text(
                        "Cerrar sesion",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePageHeaderWidget extends StatelessWidget {
  const HomePageHeaderWidget({super.key});

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
        children: [
          Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/3/3a/Cat03.jpg",
            width: double.infinity,
            height: 100.0,
            fit: BoxFit.contain,
          ),
          Text("Pagina principal", style: TextStyle(fontSize: 48.0))],
      ),
    );
  }
}
