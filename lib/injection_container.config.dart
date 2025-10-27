// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cifarx/core/api/api_client.dart' as _i534;
import 'package:cifarx/core/api/interceptors/auth_interceptor.dart' as _i410;
import 'package:cifarx/core/di/register_module.dart' as _i970;
import 'package:cifarx/core/network/network_info.dart' as _i242;
import 'package:cifarx/core/services/auth_service.dart' as _i67;
import 'package:cifarx/core/services/proactive_token_refresh_service.dart'
    as _i295;
import 'package:cifarx/core/services/theme_service.dart' as _i146;
import 'package:cifarx/core/services/token_manager.dart' as _i496;
import 'package:cifarx/core/storage/local_storage.dart' as _i81;
import 'package:cifarx/core/storage/secure_storage.dart' as _i569;
import 'package:cifarx/core/storage/token_storage_service.dart' as _i757;
import 'package:cifarx/features/auth/data/data_sources/remote/login_api_service.dart'
    as _i681;
import 'package:cifarx/features/auth/data/repository/auth_repository_impl.dart'
    as _i918;
import 'package:cifarx/features/auth/di/auth_injection.dart' as _i258;
import 'package:cifarx/features/auth/domain/repository/auth_repository.dart'
    as _i44;
import 'package:cifarx/features/auth/domain/usecases/login_user.dart' as _i280;
import 'package:cifarx/features/auth/domain/usecases/refresh_token.dart'
    as _i776;
import 'package:cifarx/features/auth/presentation/bloc/auth_bloc.dart' as _i497;
import 'package:cifarx/features/products/data/data_sources/remote/product_api_service.dart'
    as _i730;
import 'package:cifarx/features/products/data/repository/product_repository_impl.dart'
    as _i764;
import 'package:cifarx/features/products/di/products_injection.dart' as _i518;
import 'package:cifarx/features/products/domain/repository/product_repository.dart'
    as _i675;
import 'package:cifarx/features/products/domain/usecases/get_product_by_id.dart'
    as _i96;
import 'package:cifarx/features/products/domain/usecases/get_products.dart'
    as _i560;
import 'package:cifarx/features/products/domain/usecases/search_product.dart'
    as _i260;
import 'package:cifarx/features/products/presentation/bloc/product_bloc.dart'
    as _i168;
import 'package:cifarx/features/profile/data/data_sources/remote/profile_api_service.dart'
    as _i695;
import 'package:cifarx/features/profile/data/repository/profile_repository_impl.dart'
    as _i31;
import 'package:cifarx/features/profile/di/profile_injection.dart' as _i940;
import 'package:cifarx/features/profile/domain/repository/profile_repository.dart'
    as _i817;
import 'package:cifarx/features/profile/domain/usecases/get_profile.dart'
    as _i889;
import 'package:cifarx/features/profile/presentation/bloc/profile_bloc.dart'
    as _i520;
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final coreRegisterModule = _$CoreRegisterModule();
    final authModule = _$AuthModule();
    final productsModule = _$ProductsModule();
    final profileModule = _$ProfileModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => coreRegisterModule.sharedPreferences,
      preResolve: true,
    );
    gh.singleton<_i146.ThemeService>(() => _i146.ThemeService());
    gh.singleton<_i757.TokenStorageService>(() => _i757.TokenStorageService());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => coreRegisterModule.secureStorage,
    );
    gh.lazySingleton<_i895.Connectivity>(() => coreRegisterModule.connectivity);
    gh.lazySingleton<_i361.Dio>(() => coreRegisterModule.dio);
    gh.lazySingleton<_i681.LoginApiService>(
      () => authModule.loginApiService(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i730.ProductApiService>(
      () => productsModule.productApiService(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i695.ProfileApiService>(
      () => profileModule.profileApiService(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i569.SecureStorage>(
      () => _i569.SecureStorageImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i81.LocalStorage>(
      () => _i81.LocalStorageImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i242.NetworkInfo>(
      () => _i242.NetworkInfoImpl(gh<_i895.Connectivity>()),
    );
    gh.lazySingleton<_i44.AuthRepository>(
      () => _i918.AuthRepositoryImpl(
        gh<_i681.LoginApiService>(),
        gh<_i757.TokenStorageService>(),
      ),
    );
    gh.lazySingleton<_i817.ProfileRepository>(
      () => _i31.ProfileRepositoryImpl(gh<_i695.ProfileApiService>()),
    );
    gh.singleton<_i496.TokenManager>(
      () => _i496.TokenManager(
        gh<_i757.TokenStorageService>(),
        gh<_i44.AuthRepository>(),
      ),
    );
    gh.lazySingleton<_i280.LoginUserUsecase>(
      () => _i280.LoginUserUsecase(gh<_i44.AuthRepository>()),
    );
    gh.lazySingleton<_i675.ProductRepository>(
      () => _i764.ProductRepositoryImpl(gh<_i730.ProductApiService>()),
    );
    gh.singleton<_i67.AuthService>(
      () => _i67.AuthService(
        gh<_i757.TokenStorageService>(),
        gh<_i496.TokenManager>(),
      ),
    );
    gh.factory<_i776.RefreshTokenUsecase>(
      () => _i776.RefreshTokenUsecase(gh<_i44.AuthRepository>()),
    );
    gh.lazySingleton<_i889.GetProfileUsecase>(
      () => _i889.GetProfileUsecase(gh<_i817.ProfileRepository>()),
    );
    gh.lazySingleton<_i560.GetProductsUsecase>(
      () => _i560.GetProductsUsecase(gh<_i675.ProductRepository>()),
    );
    gh.lazySingleton<_i96.GetProductByIdUsecase>(
      () => _i96.GetProductByIdUsecase(gh<_i675.ProductRepository>()),
    );
    gh.lazySingleton<_i260.SearchProductsUsecase>(
      () => _i260.SearchProductsUsecase(gh<_i675.ProductRepository>()),
    );
    gh.factory<_i497.AuthBloc>(
      () => _i497.AuthBloc(
        loginUserUsecase: gh<_i280.LoginUserUsecase>(),
        authService: gh<_i67.AuthService>(),
      ),
    );
    gh.singleton<_i295.ProactiveTokenRefreshService>(
      () => _i295.ProactiveTokenRefreshService(gh<_i67.AuthService>()),
    );
    gh.factory<_i168.ProductBloc>(
      () => _i168.ProductBloc(
        gh<_i560.GetProductsUsecase>(),
        gh<_i260.SearchProductsUsecase>(),
        gh<_i96.GetProductByIdUsecase>(),
      ),
    );
    gh.factory<_i410.AuthInterceptor>(
      () => _i410.AuthInterceptor(
        gh<_i67.AuthService>(),
        gh<_i496.TokenManager>(),
      ),
    );
    gh.factory<_i520.ProfileBloc>(
      () => _i520.ProfileBloc(getProfileUsecase: gh<_i889.GetProfileUsecase>()),
    );
    gh.singleton<_i534.ApiClient>(
      () => _i534.ApiClient(gh<_i410.AuthInterceptor>()),
    );
    return this;
  }
}

class _$CoreRegisterModule extends _i970.CoreRegisterModule {}

class _$AuthModule extends _i258.AuthModule {}

class _$ProductsModule extends _i518.ProductsModule {}

class _$ProfileModule extends _i940.ProfileModule {}
