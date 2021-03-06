import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import '../providers/products_provider.dart';
import '../screens/edit_product_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    print("Build() - UserProductsScreen");
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    return Row(
      children: [
        if (screenWidth > 800) ...{AppDrawer()},
        Expanded(
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 48,
              title: const Text("Your Products"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditProductScreen.routeName);
                  },
                ),
              ],
            ),
            drawer: screenWidth < 800 ? AppDrawer() : null,
            body: FutureBuilder(
              future: _refreshProducts(context),
              builder: (context, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? const Center(
                          child: const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  const Color(0xff1E4E5F))),
                        )
                      : RefreshIndicator(
                          onRefresh: () => _refreshProducts(context),
                          color: const Color(0xff1E4E5F),
                          child: Consumer<ProductsProvider>(
                            builder: (context, productsData, _) => Padding(
                              padding: const EdgeInsets.all(8),
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(
                                  parent: const AlwaysScrollableScrollPhysics(),
                                ),
                                itemCount: productsData.items.length,
                                itemBuilder: (context, i) => Column(
                                  children: [
                                    UserProductItem(
                                      id: productsData.items[i].id,
                                      title: productsData.items[i].title,
                                      imageUrl: productsData.items[i].imageUrl,
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
            ),
          ),
        ),
      ],
    );
  }
}
