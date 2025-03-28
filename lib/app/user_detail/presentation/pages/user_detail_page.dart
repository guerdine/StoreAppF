import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
import 'package:storeapp/app/user_detail/presentation/bloc/user_detail_bloc.dart';
import 'package:storeapp/app/user_detail/presentation/bloc/user_detail_event.dart';
import 'package:storeapp/app/user_detail/presentation/bloc/user_detail_state.dart';
import 'package:storeapp/app/user_detail/presentation/model/user_model.dart';

class UserDetailPage extends StatelessWidget {
  const UserDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider.value(
        value: DependencyInjection.serviceLocator.get<UserDetailBloc>(),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: AppBarWidget(),
          ),
          body: UserListWidget(),
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(), // Hace espacio para el FAB
            notchMargin: 8.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_bag_rounded),
                  onPressed: () => GoRouter.of(context).go("/"),
                ),
                IconButton(
                  icon: Icon(Icons.people_rounded),
                  onPressed: () => GoRouter.of(context).go("/user-detail"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserDetailBloc>();
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 180, 100, 194),
      title: Text("Lista de Usuarios", style: TextStyle(color: Colors.white)),
      actions: [
        InkWell(
          onTap:
              () => showDialog(
                context: context,
                builder:
                    (dialogContext) => AlertDialog(
                      title: const Text("Cerrar Sesión"),
                      content: Text("¿Está seguro que desea cerrar sesión"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                              dialogContext,
                              'OK',
                            ); // Usa dialogContext en lugar de context
                            bloc.add(UserLogoutEvent());
                          },
                          child: const Text("OK"),
                        ),
                        TextButton(
                          onPressed:
                              () => Navigator.pop(dialogContext, "Cancelar"),
                          child: const Text("Cancelar"),
                        ),
                      ],
                    ),
              ),
          child: Icon(Icons.logout, color: Colors.white),
        ),
        SizedBox(width: 16.0),
      ],
    );
  }
}

class UserListWidget extends StatefulWidget {
  const UserListWidget({super.key});

  @override
  State<UserListWidget> createState() => _UserListWidget();
}

class _UserListWidget extends State<UserListWidget> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserDetailBloc>();
    bloc.add(GetUsersEvent());
    return BlocConsumer<UserDetailBloc, UserDetailState>(
      listener: (context, state) {
        switch (state) {
          case UserLoadingState() || UserEmptyState() || UserLoadDataState():
            break;
          case UserHomeErrorState():
            showDialog(
              context: context,
              builder:
                  (BuildContext context) => AlertDialog(
                    title: const Text('Error'),
                    content: Text(state.message),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'OK');
                          bloc.add(GetUsersEvent());
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );
          case UserLogoutState():
            GoRouter.of(context).goNamed("login");
        }
      },
      builder: (context, state) {
        switch (state) {
          case UserLoadingState():
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20.0),
                  Text(state.message),
                ],
              ),
            );
          case UserEmptyState():
            return Center(child: Text("No se encontraron productos"));
          case UserLoadDataState():
            return ListView.builder(
              itemCount: state.model.users.length,
              itemBuilder:
                  (context, index) => UserItemWidget(state.model.users[index]),
            );

          default:
            return Container();
        }
      },
    );
  }
}

class UserItemWidget extends StatelessWidget {
  final UserModel user;

  const UserItemWidget(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Bordes redondeados
        ),
        elevation: 4, // Sombra para darle efecto flotante
        color: const Color.fromARGB(255, 226, 216, 228), // Fondo suave
        child: Padding(
          padding: const EdgeInsets.all(10), // Espaciado interno
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50), // Redondear imagen
                child: CachedNetworkImage(
                  imageUrl: user.urlImage,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 15), // Espaciado entre imagen y texto
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Alinear texto
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Centrar verticalmente
                  children: [
                    Text(
                      user.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold, // Nombre en negrita
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      user.email,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    Text(
                      user.password,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
