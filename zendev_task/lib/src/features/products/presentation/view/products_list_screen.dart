import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zendev_task/src/config/app_theme.dart';
import 'package:zendev_task/src/features/products/presentation/blocs/category/category_bloc.dart';
import 'package:zendev_task/src/features/products/presentation/blocs/product/product_bloc.dart';
import 'package:zendev_task/src/shared/presentation/widgets/custom_search_bar.dart';
import 'package:zendev_task/src/shared/presentation/widgets/custome_product_home_card.dart';
import 'package:zendev_task/src/shared/presentation/widgets/filter_modal.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
          style: TextStyle(
              fontFamily: 'Rubik', fontWeight: FontWeight.w700, fontSize: 18),
        ),
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SearchBarWidget(
                  onChanged: (value) {
                    final ProductBloc productBloc =
                        BlocProvider.of<ProductBloc>(context);
                    productBloc.add(FetchProductsEvent(searchString: value));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8F0),
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return const FilterModal();
                          },
                        );
                      },
                      icon: Image.asset(
                        'assets/icons/filter_icon.png',
                        height: 36.0,
                        width: 36.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                final CategoryBloc categoryBloc =
                    BlocProvider.of<CategoryBloc>(context);

                if (state is CategoryInitial || state is CategoryLoadingState) {
                  categoryBloc.add(FetchCategoryEvent());

                  return const Center(child: CircularProgressIndicator());
                } else if (state is CategoryLoadedState) {
                  return Container(
                    color: AppTheme.secColor,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            List.generate(state.categories.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCategoryIndex = index;
                                });
                                final ProductBloc productBloc =
                                    BlocProvider.of<ProductBloc>(context);

                                productBloc.add(FetchProductsEvent(
                                    selectedCategory: _selectedCategoryIndex !=
                                            0
                                        ? state
                                            .categories[_selectedCategoryIndex]
                                        : null));
                              },
                              child: Chip(
                                label: Text(
                                  state.categories[index],
                                  style: TextStyle(
                                      color: _selectedCategoryIndex == index
                                          ? AppTheme.secColor
                                          : AppTheme.primaryColor),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                backgroundColor: _selectedCategoryIndex == index
                                    ? AppTheme.primaryColor
                                    : AppTheme.secColor,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  );
                } else if (state is CategoryErrorState) {
                  return Text('Error: ${state.error}');
                } else {
                  return Container();
                }
              },
            ),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                final ProductBloc productBloc =
                    BlocProvider.of<ProductBloc>(context);

                if (state is ProductInitial || state is ProductLoadingState) {
                  if (_selectedCategoryIndex == 0) {
                    productBloc.add(const FetchProductsEvent());
                  }
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 50.0),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: AppTheme.primaryColor,
                    )),
                  );
                } else if (state is ProductLoadedState) {
                  return state.products.isNotEmpty
                      ? Column(
                          children: state.products
                              .map((product) =>
                                  ProductListHomeCard(product: product))
                              .toList())
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/img/EmptyState.png',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'There are currently no products to display.',
                                style: TextStyle(
                                  fontFamily: 'SourceSansPro',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        );
                } else if (state is ProductErrorState) {
                  return Text('Error: ${state.error}');
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
