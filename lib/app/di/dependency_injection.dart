import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:storeapp/app/core/data/remote/service/product_service.dart';
import 'package:storeapp/app/core/data/remote/service/user_service.dart';
import 'package:storeapp/app/core/data/repository/session_repository_impl.dart';
import 'package:storeapp/app/core/domain/repository/session_repository.dart';
import 'package:storeapp/app/core/domain/use_case/logout_use_case.dart';
import 'package:storeapp/app/form_product/data/repository/form_product_repository_impl.dart';
import 'package:storeapp/app/form_product/domain/repository/form_product_repository.dart';
import 'package:storeapp/app/form_product/domain/use_case/add_product_use_case.dart';
import 'package:storeapp/app/form_product/domain/use_case/get_product_use_case.dart';
import 'package:storeapp/app/form_product/domain/use_case/update_product_use_case.dart';
import 'package:storeapp/app/form_product/presentation/bloc/form_product_bloc.dart';
import 'package:storeapp/app/home/data/repository/home_repository_impl.dart';
import 'package:storeapp/app/home/domain/repository/home_repository.dart';
import 'package:storeapp/app/home/domain/use_case/delete_products_use_case.dart';
import 'package:storeapp/app/home/domain/use_case/get_products_use_case.dart';
import 'package:storeapp/app/home/presentation/bloc/home_bloc.dart';
import 'package:storeapp/app/login/data/repository/login_repository_impl.dart';
import 'package:storeapp/app/login/domain/repository/login_repository.dart';
import 'package:storeapp/app/login/domain/use_case/login_use_case.dart';
import 'package:storeapp/app/login/presentation/bloc/login_bloc.dart';
import 'package:storeapp/app/signup/data/repository/sign_up_repository_impl.dart';
import 'package:storeapp/app/signup/domain/repository/signup_repository.dart';
import 'package:storeapp/app/signup/domain/use_case/add_user_use_case.dart';
import 'package:storeapp/app/signup/presentation/bloc/signup_bloc.dart';
import 'package:storeapp/app/user_detail/data/repository/user_detail_repository_impl.dart';
import 'package:storeapp/app/user_detail/domain/repository/user_detail_repository.dart';
import 'package:storeapp/app/user_detail/domain/use_case/get_users_use_case.dart';
import 'package:storeapp/app/user_detail/presentation/bloc/user_detail_bloc.dart';

final class DependencyInjection {
  DependencyInjection._();

  static final serviceLocator = GetIt.instance;

  static setup() {
    //dio
    serviceLocator.registerSingleton<Dio>(Dio());
    serviceLocator.registerFactory<ProductService>(
      () => ProductService(dio: serviceLocator.get()),
    );

    //login
    serviceLocator.registerFactory<LoginRepository>(
      () => LoginRepositoryImpl(),
    );
    serviceLocator.registerFactory<LoginUseCase>(
      () => LoginUseCase(loginRepository: serviceLocator.get()),
    );
    serviceLocator.registerFactory<LoginBloc>(
      () => LoginBloc(loginUseCase: serviceLocator.get()),
    );

    //home
    serviceLocator.registerFactory<HomeRepository>(
      () => HomeRepositoryImpl(productService: serviceLocator.get()),
    );

    serviceLocator.registerFactory<SessionRepository>(
      () => SessionRepositoryImpl());
    serviceLocator.registerFactory<LogoutUseCase>(
      () => LogoutUseCase(sessionRepository: serviceLocator.get()),
    );


    serviceLocator.registerFactory<GetProductsUseCase>(
      () => GetProductsUseCase(homeRepository: serviceLocator.get()),
    );
    serviceLocator.registerFactory<DeleteProductsUseCase>(
      () => DeleteProductsUseCase(homeRepository: serviceLocator.get()),
    );
    
    serviceLocator.registerFactory<HomeBloc>(
      () => HomeBloc(
        getProductsUseCase: serviceLocator.get(),
        deleteProductsUseCase: serviceLocator.get(),
        logoutUseCase: serviceLocator.get(),
      ),
    );

    //addproduct
    serviceLocator.registerFactory<FormProductRepository>(
      () => FormProductRepositoryImpl(productService: serviceLocator.get()),
    );
    serviceLocator.registerFactory<AddProductUseCase>(
      () => AddProductUseCase(formProductRepository: serviceLocator.get()),
    );
    serviceLocator.registerFactory<GetProductUseCase>(
      () => GetProductUseCase(formProductRepository: serviceLocator.get()),
    );
    serviceLocator.registerFactory<UpdateProductUseCase>(
      () => UpdateProductUseCase(formProductRepository: serviceLocator.get()),
    );

    serviceLocator.registerFactory<FormProductBloc>(
      () => FormProductBloc(
        addProductUseCase: serviceLocator.get(),
        getProductUseCase: serviceLocator.get(),
        updateProductUseCase: serviceLocator.get(),
      ),
    );

    //user-detail
    serviceLocator.registerFactory<UserService>(
       () => UserService(dio: serviceLocator.get()),
     );

    serviceLocator.registerFactory<UserDetailRepository>(
       () => UserDetailRepositoryImpl(userService: serviceLocator.get()),
     );
     serviceLocator.registerFactory<GetUsersUseCase>(
       () => GetUsersUseCase(homeAccountRepository: serviceLocator.get()),
     );
     serviceLocator.registerFactory<UserDetailBloc>(
       () => UserDetailBloc(
         getUsersUseCase: serviceLocator.get(),
         logoutUseCase: serviceLocator.get(),
       ),
     ); 

     //signup
     serviceLocator.registerFactory<SignupRepository>(
       () => SignupRepositoryImpl(userService: serviceLocator.get()),
     );
     serviceLocator.registerFactory<AddUserUseCase>(
       () => AddUserUseCase(signupRepository: serviceLocator.get()),
     );
     serviceLocator.registerFactory<SignupBloc>(
       () => SignupBloc(
         addUserUseCase: serviceLocator.get(),
         //getUserUseCase: serviceLocator.get(),
       ),
     );
  }
}
