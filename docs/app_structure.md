# App structure — CifarX

Generated: 2025-10-26

This document describes the current application structure under `lib/` and how it maps to Clean Architecture. It also includes notes, suggestions, and recommended next steps.

## Project tree (relevant `lib/` files)

- lib/
  - main.dart
  - app/
    - `app.dart` — app root widget
    - routes/
      - `app_routes.dart` — GoRouter configuration
    - theme/
      - `app_theme.dart` — app ThemeData
  - core/
    - usecase/
      - `usecase.dart` — base UseCase class (core helpers)
  - features/
    - products/
      - data/
        - data_sources/
          - `product_remote_data_source.dart`
        - repository/
          - `product_repository_impl.dart`
        - models/
          - `product_list_model.dart`
          - `product_model.dart`
          - `review_model.dart`
      - domain/
        - entity/
          - `product_entity.dart`
          - `product_list_entity.dart`
          - `reviews_entity.dart`
        - repository/
          - `product_repository.dart` (interface)
        - usecases/
          - `get_paginated_products_use_case.dart`
          - `get_product_details_use_case.dart`
          - `refresh_products_use_case.dart`
          - `search_products_use_case.dart`
      - presentation/
        - bloc/
          - `products_bloc.dart`
          - `products_event.dart`
          - `products_state.dart`
        - pages/
          - `products_list.dart`
          - `product_details.dart`
        - widgets/
          - `product_card.dart`

## Clean Architecture mapping

-- Presentation layer
  - Location: `lib/features/<feature>/presentation/` (BLoCs, pages, widgets)
  - Responsibility: UI, state management, user interactions.
-- Domain layer
  - Location: `lib/features/<feature>/domain/` (entities, repository interfaces, use cases)
  - Responsibility: Business rules, use case orchestration, repository contracts.
-- Data layer
  - Location: `lib/features/<feature>/data/` (models, data sources, repository impls)
  - Responsibility: Data retrieval (remote/local), mapping to domain entities, implementing repository interfaces.
- Core/shared
  - Location: `lib/core/` and `lib/app/` for app-level wiring (routing, theme)
  - Responsibility: Cross-cutting utilities (e.g., `UseCase` base class), app theme, routing, DI (if added).

## Notable observations and actionable notes

1. `freatures` was previously misspelled in the documentation. The repository now contains `lib/features/` (confirmed). Verify there are no remaining imports referencing `freatures` and run `flutter analyze` to catch any broken imports.

2. Routing
   - `lib/app/routes/app_routes.dart` is set up with GoRouter and currently maps `/` to `ProductsList` and `/product/:id` to `ProductDetails`.
   - `ProductDetails` currently has no constructor parameter for an `id`. If you want deep-linking and parameterized details pages, update `ProductDetails` to accept an `id` (or accept `state.extra`) and parse `state.params['id']` in the route builder.

3. Dependency management / DI
  - A dependency injection file exists at `lib/app/injection.dart`, but it appears to be empty or not yet implemented. Implement DI registration (repositories, use cases, BLoCs) there and call the initialization function from `main.dart` before `runApp()` to wire the app dependencies.

4. Shared types and errors
   - The repo already contains `core/` for `UseCase`. Consider adding `core/error/` and `core/network/` for `Failure` types and network utilities if they don't already exist.

## Suggested next steps (prioritized)

1. (Low) Verify there are no remaining imports referencing `freatures` and run `flutter analyze` to catch any broken imports.
2. (High) Implement DI in `lib/app/injection.dart` to register `ProductRepositoryImpl`, use cases, and `ProductsBloc`. Then call the DI initialization in `main.dart` before `runApp()`.
3. (Medium) Update `ProductDetails` to accept an `int id` and pass the `state.params['id']` from the route builder.
4. (Medium) Add example navigation from `ProductsList` to a product detail using `context.go('/product/123')` or `context.goNamed('productDetails', params: {'id':'123'})`.
5. (Low) Add `core/error/` with `Failure` classes and expand `core/usecase` if needed.

## Quick verification commands

Run these from the repository root (PowerShell):

```powershell
# Static analysis
flutter analyze

# Run app on the default device
flutter run
```

If you rename folders or change imports, run `flutter pub get` and `flutter analyze` again.

## Example: How to pass product id to `ProductDetails` (implementation hint)

- Update the widget:

```dart
class ProductDetails extends StatelessWidget {
  final int id;
  const ProductDetails({super.key, required this.id});
  // ...
}
```

- Update the route builder:

```dart
GoRoute(
  path: '/product/:id',
  builder: (context, state) {
    final id = int.tryParse(state.params['id'] ?? '') ?? 0;
    return ProductDetails(id: id);
  },
),
```

## Completion

This file was generated automatically to capture the current `lib/` layout and provide actionable guidance for aligning with Clean Architecture. Update the document as the project evolves.
