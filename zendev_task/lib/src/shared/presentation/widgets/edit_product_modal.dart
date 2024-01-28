import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zendev_task/src/config/app_theme.dart';
import 'package:zendev_task/src/features/products/presentation/blocs/product/product_bloc.dart';
import 'package:zendev_task/src/shared/data/models/products_model.dart';
import 'package:zendev_task/src/shared/presentation/widgets/custom_button.dart';
import 'package:zendev_task/src/shared/presentation/widgets/custom_snack_bar.dart';

class EditProductModal extends StatefulWidget {
  final Product product;

  const EditProductModal({required this.product, super.key});

  @override
  State<EditProductModal> createState() => _EditProductModalState();
}

class _EditProductModalState extends State<EditProductModal> {
  late String _selectedCategory;
  List<String> tempCategoryTitles = [
    'all',
    'electronics',
    'jewelery',
    'men\'s clothing',
    'women\'s clothing',
  ];

  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    _selectedCategory = widget.product.category;
    titleController.text = widget.product.title;
    priceController.text = widget.product.price.toString();
    descController.text = widget.product.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 720,
        color: Colors.white, // Boja pozadine modala
        child: Center(
          child: Column(
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
                  widget.product.title,
                  style: const TextStyle(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Title',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      width: 358,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFFFCF99)),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor: AppTheme.secColor,
                          hintText: 'Enter product title',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Price',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                          width: 107,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFFFFCF99)), // Boja ivice
                            borderRadius: BorderRadius.circular(
                                8.0), // Opciono: zaobljenje ivice
                          ),
                          child: TextField(
                            controller: priceController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8.0),
                              ),

                              filled: true,
                              fillColor: AppTheme.secColor,
                              hintText: 'Price', // Pomoćni tekst
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Category',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppTheme.borderColor),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          width: 235,
                          child: DropdownButtonFormField<String>(
                            value: widget.product.category,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppTheme.secColor,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedCategory = newValue!;
                              });
                            },
                            items: tempCategoryTitles.map((String category) {
                              return DropdownMenuItem<String>(
                                value: category,
                                child: Text(category),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      width: 358,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.borderColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        controller: descController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppTheme.secColor,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
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
                    text: 'Save',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Warning?"),
                            content: const Text(
                                "Are you sure you want to edit the product?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Product product = Product(
                                      id: widget.product.id,
                                      title: titleController.text,
                                      price: double.parse(priceController.text),
                                      category: _selectedCategory,
                                      description: descController.text,
                                      imageUrl: widget.product.imageUrl);
                                  final ProductBloc productBloc =
                                      BlocProvider.of<ProductBloc>(context);
                                  productBloc
                                      .add(EditProductsEvent(product: product));
                                  context.go('/');
                                  CustomSnackBar.show(
                                      context,
                                      'You have successfully edited the product.',
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
                    buttonColor:
                        AppTheme.primaryColor, // Postavljanje boje buttona
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
                    buttonColor: Colors.white, // Postavljanje boje buttona
                    textColor: AppTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
