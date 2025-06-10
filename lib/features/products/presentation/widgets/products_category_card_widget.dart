import 'package:flutter/material.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/entities/entities.dart';

class ProductsCategoryCardWidget extends StatelessWidget {
  final Product product;

  const ProductsCategoryCardWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
                width: double.infinity,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) =>
                    const Center(child: Icon(Icons.error)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '\$${product.price}',
              style: const TextStyle(
                color: Colors.red, 
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                elevation: 0,
              ),
              child: Text("Agregar", style: TextStyle(color: Colors.white),),
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {}, 
                  icon: Icon(Icons.do_not_disturb_on_outlined),
                ),
                Text('2 und'),
                IconButton(
                  onPressed: () {}, 
                  icon: Icon(Icons.add_circle_outline_rounded),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}