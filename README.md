# CifarX

![Flutter](https://img.shields.io/badge/Flutter-3.32.4-blue?logo=flutter) ![Dart](https://img.shields.io/badge/Dart-3.8.1-blue?logo=dart) ![BLoC](https://img.shields.io/badge/BLoC-State%20Management-brightgreen) ![GoRouter](https://img.shields.io/badge/GoRouter-Navigation-orange)

A **Flutter app** that fetches and displays a paginated list of products from a public JSON API.  
Built for the **Flutter (Mid-Level) first round task**.

---

## Overview

CifarX loads products from the [DummyJSON API](https://dummyjson.com) with **pagination** (10 items per page) and **infinite scrolling**.  
The app uses **BLoC** for state management, **GoRouter** for navigation, and follows **Clean Architecture** principles.

---

## Features

- ✅ Paginated product list (10 items per page)  
- ✅ Infinite scroll with auto-loading  
- ✅ Loading, success, and error states  
- ✅ Friendly messages for other errors with retry option  
- ✅ Clean and modular folder structure  
- ✅ Dependency injection with `get_it` + `injectable`  
- ✅ Functional error handling using `fpdart (Either)`  

---

## API Used

**[DummyJSON API](https://dummyjson.com/products)**  

---

## Folder Structure
- lib/
  - app/
    - routes/
      - app_routes.dart
    - theme/
      - app_theme.dart
  - config/
    - theme/
      - app_colors.dart
      - app_theme.dart
  - core/
    - api/
      - api_client.dart
      - interceptors/
      - models/
        - api_response.dart
        - pagination_model.dart
        - pagination_model.g.dart
    - constants/
      - api_constants.dart
      - app_constants.dart
      - storage_keys.dart
    - di/
    - error/
    - navigation/
      - app_router.dart
    - network/
    - presentation/
      - extensions/
        - date_extensions.dart
      - widgets/
        - app_bottom_navigation.dart
        - app_drawer.dart
        - empty_state_widget.dart
    - services/
    - storage/
      - token_storage_service.dart
    - utils/
      - app_utils.dart
  - features/
    - auth/
      - data/
        - repository/
          - auth_repository_impl.dart
      - domain/
        - entities/
          - user.dart
        - params/
          - login_params.dart
        - repository/
          - auth_repository.dart
      - presentation/
        - bloc/
          - auth_bloc.dart
        - pages/
          - login_page.dart
    - products/
      - domain/
        - entities/
          - product.dart
      - presentation/
        - bloc/
          - product_bloc.dart
        - pages/
          - product_list.dart
        - widgets/
          - product_card.dart
    - profile/
      - data/
        - repository/
          - profile_repository_impl.dart
      - domain/
        - entities/
          - profile.dart
        - repository/
          - profile_repository.dart
  - injection_container.dart
  - injection_container.config.dart

  ---

  ## Navigation

- Managed with **GoRouter**  
- Routes are defined centrally in `app/routes/app_routes.dart`  
- Clean navigation flow following Clean Architecture principles  

---

## 🧱 Tech Stack

| Category | Tools |
|----------|-------|
| State Management | `flutter_bloc`, `equatable` |
| Networking | `dio`, `retrofit` |
| Navigation | `go_router` |
| Dependency Injection | `get_it`, `injectable` |
| Functional Programming | `fpdart` |
| Storage | `shared_preferences`, `flutter_secure_storage` |
| UI | `shimmer`, `google_fonts` |

---

## 📱 APK

The release APK is available in the /APK folder.

---

Contact: mehadireaz@gmail.com  
Mobile: 01733901774