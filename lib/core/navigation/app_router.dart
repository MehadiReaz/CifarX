import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cifarx/core/navigation/app_routes.dart';
import 'package:cifarx/features/products/presentation/pages/product_list.dart';
import 'package:cifarx/features/products/presentation/pages/product_details_page.dart';
import 'package:cifarx/features/products/presentation/bloc/product_bloc.dart';
import 'package:cifarx/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cifarx/features/auth/presentation/widgets/auth_wrapper.dart';
import 'package:cifarx/features/profile/presentation/pages/profile_page.dart';
import 'package:cifarx/features/settings/presentation/pages/settings_page.dart';
import 'package:cifarx/core/presentation/widgets/app_bottom_navigation.dart';
import 'package:cifarx/injection_container.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider(
            create: (context) => getIt<AuthBloc>(),
            child: AuthWrapper(
              child: MainScaffold(
                currentPath: state.matchedLocation,
                child: child,
              ),
            ),
          );
        },
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: 'home',
            builder: (context, state) => const ProductList(),
          ),
          GoRoute(
            path: AppRoutes.products,
            name: 'products',
            builder: (context, state) => const ProductList(),
          ),
          GoRoute(
            path: AppRoutes.search,
            name: 'search',
            builder: (context, state) {
              final query = state.uri.queryParameters['q'] ?? '';
              return SearchPage(initialQuery: query);
            },
          ),
          GoRoute(
            path: AppRoutes.profile,
            name: 'profile',
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),
      // Routes without bottom navigation
      GoRoute(
        path: AppRoutes.productDetail,
        name: 'product-detail',
        builder: (context, state) {
          final productId = state.pathParameters['id']!;
          return BlocProvider(
            create: (context) =>
                getIt<ProductBloc>()..add(GetProductDetailsEvent(productId)),
            child: const ProductDetailsPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.settings,
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );

  static GoRouter get router => _router;
}

// Placeholder pages - these would be implemented as needed
class SearchPage extends StatelessWidget {
  final String initialQuery;

  const SearchPage({super.key, required this.initialQuery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Search Query: $initialQuery'),
            const Text('Search results will be shown here'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 100, color: Colors.red),
            const SizedBox(height: 20),
            const Text('404 - Page Not Found', style: TextStyle(fontSize: 24)),
            const Text('The page you are looking for does not exist.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
