import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zendev_task/src/config/app_theme.dart';
import 'package:zendev_task/src/features/products/presentation/blocs/product/product_bloc.dart';
import 'package:zendev_task/src/shared/data/models/products_model.dart';
import 'package:zendev_task/src/shared/presentation/widgets/custom_button.dart';
import 'package:zendev_task/src/shared/presentation/widgets/custom_snack_bar.dart';
import 'package:zendev_task/src/shared/presentation/widgets/edit_product_modal.dart';

class DeleteEditModal extends StatelessWidget {
  final Product product;
  const DeleteEditModal({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 312,
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.title,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.buttonColor),
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
                  icon: Icons.edit,
                  text: 'Edit product',
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return EditProductModal(
                          product: product,
                        );
                      },
                    );
                  },
                  buttonColor: AppTheme.primaryColor,
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
                  icon: Icons.delete,
                  text: 'Delete product',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Warning?"),
                          content: const Text(
                              "Are you sure you want to delete the product?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                final ProductBloc productBloc =
                                    BlocProvider.of<ProductBloc>(context);
                                productBloc.add(DeleteProductsEvent(
                                    producetId: product.id));
                                context.go('/');
                                CustomSnackBar.show(
                                    context,
                                    'You have successfully deleted the product.',
                                    AppTheme.primaryColor);
                              },
                              child: const Text("Yes"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("No"),
                            ),
                          ],
                        );
                      },
                    );
                  },
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
