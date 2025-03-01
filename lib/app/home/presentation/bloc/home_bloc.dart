import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/home/domain/use_case/delete_products_use_case.dart';
import 'package:storeapp/app/home/domain/use_case/get_products_use_case.dart';
import 'package:storeapp/app/home/presentation/bloc/home_event.dart';
import 'package:storeapp/app/home/presentation/bloc/home_state.dart';
import 'package:storeapp/app/home/presentation/model/product_model.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProductsUseCase getProductsUseCase;
  final DeleteProductsUseCase deleteProductsUseCase;

  HomeBloc({required this.getProductsUseCase, required this.deleteProductsUseCase}) : super((LoadingState())) {
    on<GetProductsEvent>(_pGetProductsEvent);
    on<DeleteProductEvent>(_pDeleteProductEvent);
  }

  void _pGetProductsEvent(GetProductsEvent event,Emitter<HomeState> emit,) {
    late HomeState newState;

    try {
      newState = LoadingState();
      emit(newState);

      final List<ProductModel> result = getProductsUseCase.invoke();
      if (result.isEmpty) {
        newState = EmptyState();
      }else{
        newState = LoadDataState(model: state.model.copyWith(products: result));
      }
    } catch (e) {
      newState = HomeErrorState(model: state.model, message: "Error al obtener los productos." );
    }
    emit(newState);
  }

  void _pDeleteProductEvent(DeleteProductEvent event,Emitter<HomeState> emit,) {
    
    late HomeState newState;

    try {
      newState = LoadingState();
      emit(newState);
      final bool result = deleteProductsUseCase.invoke(event.id);
      
      if (result) {
        _pGetProductsEvent(GetProductsEvent(),emit);
      } else {
        throw(Exception());
      }
    } catch (e) {
      newState = HomeErrorState(model: state.model, message: "Error al obtener los productos." );
      emit(newState);
    }
  }
  

}
