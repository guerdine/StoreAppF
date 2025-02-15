import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/login/presentation/pages/login_page.dart';
import 'package:storeapp/app/signup/presentation/pages/signup_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        /*el builder recibe 2 params, se usa _ para decir que ignore un statement, 
     como necesito ignorar ambos params, pues se define con doble _
    */
        GoRoute(path: "/", builder: (_, _) => LoginPage(), name: "login"),
        GoRoute(
          path: "/sign-up",
          builder: (_, _) => SignupPage(),
          name: "sign-up",
        ),
      ],
    );
    return MaterialApp.router(routerConfig: router);
  }
}

class TestStateful extends StatefulWidget {
  const TestStateful({super.key});

  @override
  State<TestStateful> createState() => 
   TestStatefulState();
}

class TestStatefulState extends State<TestStateful>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container();
  }

}

