import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zendev_task/src/config/app_router.dart';
import 'package:zendev_task/src/config/app_theme.dart';
import 'package:zendev_task/src/features/products/data/repositories/category_repository_impl.dart';
import 'package:zendev_task/src/features/products/data/repositories/product_repository_impl.dart';
import 'package:zendev_task/src/features/products/presentation/blocs/category/category_bloc.dart';
import 'package:zendev_task/src/features/products/presentation/blocs/product/product_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBloc(
            productRepository: ProductRepositoryImpl(),
          ),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(
            categoryRepositoryImpl: CategoryRepositoryImpl(),
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            title: 'ZenDev Task',
            theme: AppTheme().theme(),
            routerConfig: AppRouter().router,
          );
        },
      ),
    );
  }
}
