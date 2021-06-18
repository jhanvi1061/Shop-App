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
        .fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    print("Build() - UserProductsScreen");
    final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        title: const Text(
          "Your Products",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        color: Color(0xff1E4E5F),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
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
    );
  }
}
