// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:cifarx/core/api/api_client.dart' as _i722;
import 'package:cifarx/core/api/interceptors/auth_interceptor.dart' as _i402;
import 'package:cifarx/core/di/register_module.dart' as _i887;
import 'package:cifarx/core/network/network_info.dart' as _i202;
import 'package:cifarx/core/services/auth_service.dart' as _i629;
import 'package:cifarx/core/services/proactive_token_refresh_service.dart'
    as _i612;
import 'package:cifarx/core/services/theme_service.dart' as _i536;
import 'package:cifarx/core/services/token_manager.dart' as _i769;
import 'package:cifarx/core/storage/local_storage.dart' as _i430;
import 'package:cifarx/core/storage/secure_storage.dart' as _i73;
import 'package:cifarx/core/storage/token_storage_service.dart' as _i991;
import 'package:cifarx/features/auth/data/data_sources/remote/login_api_service.dart'
    as _i3;
import 'package:cifarx/features/auth/data/repository/auth_repository_impl.dart'
    as _i228;
import 'package:cifarx/features/auth/di/auth_injection.dart' as _i174;
import 'package:cifarx/features/auth/domain/repository/auth_repository.dart'
    as _i140;
import 'package:cifarx/features/auth/domain/usecases/login_user.dart' as _i549;
import 'package:cifarx/features/auth/domain/usecases/refresh_token.dart'
    as _i66;
import 'package:cifarx/features/auth/presentation/bloc/auth_bloc.dart' as _i838;
import 'package:cifarx/features/products/data/data_sources/remote/product_api_service.dart'
    as _i696;
import 'package:cifarx/features/products/data/repository/product_repository_impl.dart'
    as _i431;
import 'package:cifarx/features/products/di/products_injection.dart' as _i345;
import 'package:cifarx/features/products/domain/repository/product_repository.dart'
    as _i714;
import 'package:cifarx/features/products/domain/usecases/get_product_by_id.dart'
    as _i211;
import 'package:cifarx/features/products/domain/usecases/get_products.dart'
    as _i45;
import 'package:cifarx/features/products/domain/usecases/search_product.dart'
    as _i827;
import 'package:cifarx/features/products/presentation/bloc/product_bloc.dart'
    as _i121;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final coreRegisterModule = _$CoreRegisterModule();
    final productsModule = _$ProductsModule();
    final authModule = _$AuthModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => coreRegisterModule.sharedPreferences,
      preResolve: true,
    );
    gh.singleton<_i991.TokenStorageService>(() => _i991.TokenStorageService());
    gh.singleton<_i536.ThemeService>(() => _i536.ThemeService());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => coreRegisterModule.secureStorage,
    );
    gh.lazySingleton<_i895.Connectivity>(() => coreRegisterModule.connectivity);
    gh.lazySingleton<_i361.Dio>(() => coreRegisterModule.dio);
    gh.lazySingleton<_i73.SecureStorage>(
      () => _i73.SecureStorageImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i430.LocalStorage>(
      () => _i430.LocalStorageImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i696.ProductApiService>(
      () => productsModule.productApiService(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i3.LoginApiService>(
      () => authModule.loginApiService(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i714.ProductRepository>(
      () => _i431.ProductRepositoryImpl(gh<_i696.ProductApiService>()),
    );
    gh.lazySingleton<_i140.AuthRepository>(
      () => _i228.AuthRepositoryImpl(
        gh<_i3.LoginApiService>(),
        gh<_i991.TokenStorageService>(),
      ),
    );
    gh.lazySingleton<_i202.NetworkInfo>(
      () => _i202.NetworkInfoImpl(gh<_i895.Connectivity>()),
    );
    gh.lazySingleton<_i45.GetProductsUsecase>(
      () => _i45.GetProductsUsecase(gh<_i714.ProductRepository>()),
    );
    gh.lazySingleton<_i211.GetProductByIdUsecase>(
      () => _i211.GetProductByIdUsecase(gh<_i714.ProductRepository>()),
    );
    gh.lazySingleton<_i827.SearchProductsUsecase>(
      () => _i827.SearchProductsUsecase(gh<_i714.ProductRepository>()),
    );
    gh.factory<_i66.RefreshTokenUsecase>(
      () => _i66.RefreshTokenUsecase(gh<_i140.AuthRepository>()),
    );
    gh.singleton<_i769.TokenManager>(
      () => _i769.TokenManager(
        gh<_i991.TokenStorageService>(),
        gh<_i140.AuthRepository>(),
      ),
    );
    gh.lazySingleton<_i549.LoginUserUsecase>(
      () => _i549.LoginUserUsecase(gh<_i140.AuthRepository>()),
    );
    gh.singleton<_i629.AuthService>(
      () => _i629.AuthService(
        gh<_i991.TokenStorageService>(),
        gh<_i769.TokenManager>(),
      ),
    );
    gh.factory<_i838.AuthBloc>(
      () => _i838.AuthBloc(
        loginUserUsecase: gh<_i549.LoginUserUsecase>(),
        authService: gh<_i629.AuthService>(),
      ),
    );
    gh.factory<_i121.ProductBloc>(
      () => _i121.ProductBloc(
        gh<_i45.GetProductsUsecase>(),
        gh<_i827.SearchProductsUsecase>(),
        gh<_i211.GetProductByIdUsecase>(),
      ),
    );
    gh.singleton<_i612.ProactiveTokenRefreshService>(
      () => _i612.ProactiveTokenRefreshService(gh<_i629.AuthService>()),
    );
    gh.factory<_i402.AuthInterceptor>(
      () => _i402.AuthInterceptor(
        gh<_i629.AuthService>(),
        gh<_i769.TokenManager>(),
      ),
    );
    gh.singleton<_i722.ApiClient>(
      () => _i722.ApiClient(gh<_i402.AuthInterceptor>()),
    );
    return this;
  }
}

class _$CoreRegisterModule extends _i887.CoreRegisterModule {}

class _$ProductsModule extends _i345.ProductsModule {}

class _$AuthModule extends _i174.AuthModule {}
