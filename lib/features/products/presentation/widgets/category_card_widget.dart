import 'package:flutter/material.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/entities/entities.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CategoryCardWidget extends StatelessWidget {

  final Category category;

  const CategoryCardWidget({
    super.key, required this.category
  });


  

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 160,
        height: 160,
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: category.image,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            SizedBox(),
            Text(
              category.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
    );
  }
}