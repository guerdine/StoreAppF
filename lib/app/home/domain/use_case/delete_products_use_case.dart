import 'package:storeapp/app/home/domain/repository/home_repository.dart';

class DeleteProductsUseCase {
  final HomeRepository homeRepository;

  DeleteProductsUseCase({required this.homeRepository});

  bool invoke(String id){
    return homeRepository.deleteProduct(id);
  }
  
}