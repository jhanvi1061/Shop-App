import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import '../providers/products_provider.dart';
import '../widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    print("Build() - ProductsGrid");
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    final productsData = Provider.of<ProductsProvider>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (context, i) => ChangeNotifierProvider.value(
        value: products[i],
        // create: (context) =>products[i],
        child: ProductItem(
            // id: products[i].id,
            // title: products[i].title,
            // imageUrl: products[i].imageUrl,
            ),
      ),
      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: screenWidth > 1200
      //       ? 4
      //       : screenWidth > 900
      //           ? 4
      //           : screenWidth > 600
      //               ? 3
      //               : screenWidth > 400
      //                   ? 2
      //                   : 1,
      //   childAspectRatio: 3 / 2.25,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
