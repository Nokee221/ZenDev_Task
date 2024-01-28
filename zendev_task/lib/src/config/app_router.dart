import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zendev_task/src/features/products/presentation/view/product_details_screen.dart';
import 'package:zendev_task/src/features/products/presentation/view/products_list_screen.dart';
import 'package:zendev_task/src/shared/data/models/products_model.dart';

class AppRouter {
  AppRouter();

  late final GoRouter router = GoRouter(routes: <GoRoute>[
    GoRoute(
      name: 'product_list',
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const ProductListScreen();
      },
    ),
    GoRoute(
      name: 'product_detail',
      path: '/product_detail',
      builder: (BuildContext context, GoRouterState state) {
        Product? product = state.extra as Product?;

        return ProductDetailsScreen(
          product: product!,
        );
      },
    ),
  ]);
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
