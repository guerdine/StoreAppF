import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/app/form_product/presentation/pages/form_product_page.dart';
import 'package:storeapp/app/home/presentation/pages/home_page.dart';
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
        GoRoute(
          path: "/login",
          builder: (_, _) => LoginPage(),
          name: "login",
          redirect: (context, state) async {
            final prefs = await SharedPreferences.getInstance();
            final bool authenticatited = prefs.getBool("login") ?? false;
            if (authenticatited) {
              return "/";
            } else {
              return null;
            }
          },
        ),
        GoRoute(
          path: "/sign-up",
          builder: (_, _) => SignupPage(),
          name: "sign-up",
        ),
        GoRoute(
          path: "/",
          builder: (_, _) => HomePage(),
          name: "home",
          redirect: (context, state) async {
            final prefs = await SharedPreferences.getInstance();
            final bool authenticatited = prefs.getBool("login") ?? false;
            if (!authenticatited) {
              return "/login";
            } else {
              return null;
            }
          },
        ),
        GoRoute(
          path: "/form-product",
          builder: (_, _) => FormProductPage(),
          name: "form-product",
        ),
        GoRoute(
          path: "/form-product/:id",
          builder:
              (_, state) => FormProductPage(id: state.pathParameters["id"]),
          name: "form-product-u",
        ),
      ],
    );
    return MaterialApp.router(routerConfig: router,debugShowCheckedModeBanner: false,);
  }
}

class TestStateful extends StatefulWidget {
  const TestStateful({super.key});

  @override
  State<TestStateful> createState() => TestStatefulState();
}

class TestStatefulState extends State<TestStateful> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
