import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zendev_task/src/config/app_theme.dart';
import 'package:zendev_task/src/features/products/presentation/blocs/category/category_bloc.dart';
import 'package:zendev_task/src/shared/presentation/widgets/custom_button.dart';

class FilterModal extends StatefulWidget {
  const FilterModal({super.key});

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  int _selectedCategoryIndex = 0;
  int _selectedPriceIndex = 0;
  int _selectedNumberOfResult = 0;

  List<String> sortByPrice = ['Highest price', 'Lowest price'];

  List<String> sortByNumberofResult = [
    '10',
    '20',
    '30',
    '50',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 620,
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 4,
                    width: 110,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Filter',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5E0F0A)),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Category',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      final CategoryBloc categoryBloc =
                          BlocProvider.of<CategoryBloc>(context);

                      if (state is CategoryInitial ||
                          state is CategoryLoadingState) {
                        categoryBloc.add(FetchCategoryEvent());

                        return const Center(child: CircularProgressIndicator());
                      } else if (state is CategoryLoadedState) {
                        return SingleChildScrollView(
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
                                  },
                                  child: Chip(
                                      label: Text(
                                        state.categories[index],
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        side: BorderSide(
                                            color:
                                                _selectedCategoryIndex == index
                                                    ? AppTheme.borderColor
                                                    : Colors.transparent),
                                      ),
                                      backgroundColor: AppTheme.secColor),
                                ),
                              );
                            }),
                          ),
                        );
                      } else if (state is CategoryErrorState) {
                        return Text('Error: ${state.error}');
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Sort by price',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(sortByPrice.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedPriceIndex = index;
                              });
                            },
                            child: Chip(
                                label: Text(
                                  sortByPrice[index],
                                  style: const TextStyle(color: Colors.black),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  side: BorderSide(
                                      color: _selectedPriceIndex == index
                                          ? AppTheme.borderColor
                                          : Colors.transparent),
                                ),
                                backgroundColor: AppTheme.secColor),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Number of results',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          List.generate(sortByNumberofResult.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedNumberOfResult = index;
                              });
                            },
                            child: Chip(
                                label: Text(
                                  sortByNumberofResult[index],
                                  style: const TextStyle(color: Colors.black),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  side: BorderSide(
                                      color: _selectedNumberOfResult == index
                                          ? AppTheme.borderColor
                                          : Colors.transparent),
                                ),
                                backgroundColor: AppTheme.secColor),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                thickness: 1,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: IconTextButton(
                  icon: null,
                  text: 'Apply Filter',
                  onPressed: () {},
                  buttonColor: AppTheme.buttonColor,
                  textColor: Colors.white,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: IconTextButton(
                  icon: null,
                  text: 'Cancel',
                  onPressed: () {},
                  buttonColor: Colors.white,
                  textColor: AppTheme.buttonColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
