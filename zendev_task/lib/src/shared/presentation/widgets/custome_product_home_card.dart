import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zendev_task/src/shared/data/models/products_model.dart';

class ProductListHomeCard extends StatelessWidget {
  final Product product;
  const ProductListHomeCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          context.push('/product_detail', extra: product);
        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  product.imageUrl,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.category,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 8.0),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      product.title,
                      style: const TextStyle(
                          fontSize: 12.0,
                          color: Color(0xFF5E0F0A),
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '\$${product.price}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.more_vert),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
