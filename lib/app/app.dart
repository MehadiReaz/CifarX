import 'package:cifarx/features/products/presentation/bloc/products_bloc.dart';
import 'package:cifarx/features/products/domain/usecases/get_paginated_products_use_case.dart';
import 'package:cifarx/features/products/data/repository/product_repository_impl.dart';
import 'package:cifarx/features/products/data/data_sources/product_remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cifarx/app/routes/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Construct the concrete data source -> repository -> use case chain here
        BlocProvider(
          create: (_) {
            final remote = ProductRemoteDataSourceImpl();
            final repo = ProductRepositoryImpl(remote);
            final usecase = GetPaginatedProductsUseCase(repo);
            return ProductsBloc(usecase);
          },
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
