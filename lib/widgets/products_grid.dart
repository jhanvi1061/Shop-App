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
    final productsData = Provider.of<ProductsProvider>(context, listen: false);
    final products = showFavs ? productsData.favoriteItems : productsData.items;
    return products.length == 0
        ? const Center(child: const Text("No Product Found"))
        : GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(10),
            itemCount: products.length,
            itemBuilder: (context, i) => ChangeNotifierProvider.value(
              value: products[i],
              child: ProductItem(),
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: screenWidth < 380
                  ? 1
                  : screenWidth < 600
                      ? 2
                      : screenWidth < 800
                          ? 3
                          : screenWidth < 1000
                              ? 2
                              : screenWidth < 1200
                                  ? 3
                                  : 4,
              childAspectRatio: screenWidth < 380
                  ? screenWidth / 200
                  : screenWidth < 600
                      ? (screenWidth / 2) / 200
                      : screenWidth < 800
                          ? (screenWidth / 2) / 320
                          : screenWidth < 1000
                              ? (screenWidth / 2) / 260
                              : screenWidth < 1200
                                  ? (screenWidth / 2) / 320
                                  : (screenWidth / 2) / 480,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          );
  }
}
