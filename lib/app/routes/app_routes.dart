import 'package:go_router/go_router.dart';
import 'package:cifarx/features/products/presentation/pages/products_list.dart';
import 'package:cifarx/features/products/presentation/pages/product_details.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      name: 'products',
      path: '/',
      builder: (context, state) => const ProductsList(),
    ),
    GoRoute(
      name: 'productDetails',
      path: '/product/:id',
      builder: (context, state) {
        // Currently ProductDetails doesn't accept an id; keep as-is
        // If you later add an `int id` param to ProductDetails, you can
        // parse it here from `state.params['id']` and pass it via the
        // constructor or `state.extra`.
        return const ProductDetails();
      },
    ),
  ],
);
