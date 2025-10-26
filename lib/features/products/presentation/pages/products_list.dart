import 'package:cifarx/features/products/domain/entity/product_entity.dart';
import 'package:cifarx/features/products/presentation/bloc/products_bloc.dart';
import 'package:cifarx/features/products/presentation/bloc/products_event.dart';
import 'package:cifarx/features/products/presentation/bloc/products_state.dart';
import 'package:cifarx/features/products/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _initializeProducts();
    _setupScrollListener();
  }

  void _initializeProducts() {
    context.read<ProductsBloc>().add(const FetchProducts());
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= 
          _scrollController.position.maxScrollExtent - 200) {
        _loadMoreProducts();
      }
    });
  }

  void _loadMoreProducts() {
    final state = context.read<ProductsBloc>().state;
    if (state.status != ProductsStatus.loading && state.status != ProductsStatus.failure) {
      context.read<ProductsBloc>().add(
        FetchProducts(
          skip: state.products.length,
        ),
      );
    }
  }

  void _refreshProducts() {
    context.read<ProductsBloc>().add(const FetchProducts(isRefresh: true));
  }

  void _searchProducts(String query) {
    if (query.trim().isEmpty) {
      context.read<ProductsBloc>().add(const FetchProducts(isRefresh: true));
    } else {
      context.read<ProductsBloc>().add(SearchProducts(query: query.trim()));
    }
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        _searchProducts('');
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search products...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: _searchProducts,
              )
            : const Text('Products'),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: _toggleSearch,
          ),
        ],
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state.status == ProductsStatus.initial && state.products.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.status == ProductsStatus.failure && state.products.isEmpty) {
            return _buildErrorState(state.errorMessage);
          }

          if (state.products.isEmpty && state.status == ProductsStatus.success) {
            return _buildEmptyState();
          }

          return RefreshIndicator(
            onRefresh: () async {
              _refreshProducts();
            },
            child: Column(
              children: [
                if (state.products.isNotEmpty) ...[
                  _buildProductsHeader(state),
                  Expanded(child: _buildProductsList(state)),
                ],
                if (state.status == ProductsStatus.loading && state.products.isEmpty)
                  const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductsHeader(ProductsState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[50],
      child: Row(
        children: [
          Text(
            '${state.products.length} Products',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          if (state.status == ProductsStatus.loading && state.products.isNotEmpty)
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsList(ProductsState state) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: state.products.length + (state.status == ProductsStatus.loading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == state.products.length && state.status == ProductsStatus.loading) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final product = state.products[index];
        return ProductCard(
          product: product,
          onTap: () => _navigateToProductDetails(product),
        );
      },
    );
  }

  Widget _buildErrorState(String? errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              errorMessage ?? 'Failed to load products',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _refreshProducts,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No products found',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your search or filters',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToProductDetails(ProductEntity product) {
    if (product.id != null) {
      context.push('/product/${product.id}');
    }
  }
}
