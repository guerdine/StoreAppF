import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
import 'package:storeapp/app/home/presentation/bloc/home_bloc.dart';
import 'package:storeapp/app/home/presentation/bloc/home_event.dart';
import 'package:storeapp/app/home/presentation/bloc/home_state.dart';
import 'package:storeapp/app/home/presentation/model/product_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider.value(
        value: DependencyInjection.serviceLocator.get<HomeBloc>(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: Text(
              "Listado de productos",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              Icon(Icons.logout, color: Colors.white),
              SizedBox(width: 16.0),
            ],
          ),
          body: ProductsListWidget(),
          floatingActionButton: FloatingActionButton(
            onPressed: () => GoRouter.of(context).pushNamed("form-product"),
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class ProductsListWidget extends StatefulWidget {
  const ProductsListWidget({super.key});
  @override
  State<ProductsListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductsListWidget> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    bloc.add(GetProductsEvent());
    return BlocConsumer<HomeBloc, HomeState>(
      //es listener y builder a la vez
      listener: (context, state) {
        switch (state) {
          case LoadingState() || EmptyState() || LoadDataState():
            break;
          case HomeErrorState():
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
                          bloc.add(GetProductsEvent());
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );
            break;
        }
      },
      builder: (context, state) {
        switch (state) {
          case LoadingState():
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
          case EmptyState():
            return Center(child: Text("No se han encontrado los productos"));
          case LoadDataState():
            return ListView.builder(
              itemCount: state.model.products.length,
              itemBuilder:
                  (context, index) =>
                      ProductItemWidget(state.model.products[index]),
            );
          default:
            return Container();
        }
      },
    );
  }
}

class ProductItemWidget extends StatelessWidget {
  final ProductModel product;

  const ProductItemWidget(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    return InkWell(
      onTap:
          () => GoRouter.of(
            context,
          ).pushNamed("form-product-u", pathParameters: {"id": product.id}),
      onLongPress:
          () => showDialog(
            context: context,
            builder:
                (BuildContext context) => AlertDialog(
                  title: const Text("Eliminación de producto"),
                  content: Text("¿Está seguro de eliminar: ${product.name}?"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                          'OK',
                        ); // Usa dialogContext en lugar de context
                        bloc.add(DeleteProductEvent(id: product.id));
                      },
                      child: const Text("OK"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, "Cancelar"),
                      child: const Text("Cancelar"),
                    ),
                  ],
                ),
          ),
      child: Card(
        child: Row(
          children: [
            Image.network(product.urlImage, width: 150.0, fit: BoxFit.contain),
            Expanded(
              child: SizedBox(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Text(product.name), Text("\$${product.price}")],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
