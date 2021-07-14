import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import '../providers/products_provider.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';

enum FilterOptions { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetProducts();
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    print("Build() - ProductsOverviewScreen");
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    return Row(
      children: [
        if (screenWidth > 800) ...{AppDrawer()},
        Expanded(
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 48,
              title: const Text("MeShop"),
              actions: [
                Consumer<Cart>(
                  child: IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    onPressed: () {
                      Navigator.of(context).pushNamed(CartScreen.routeName);
                    },
                  ),
                  builder: (context, cart, child) => Badge(
                    child: child,
                    value: cart.itemCount.toString(),
                  ),
                ),
                PopupMenuButton(
                  color: const Color(0xffFFF7EE),
                  icon: const Icon(Icons.more_vert),
                  onSelected: (FilterOptions selectedValue) {
                    setState(() {
                      if (selectedValue == FilterOptions.Favorites) {
                        _showOnlyFavorites = true;
                      } else {
                        _showOnlyFavorites = false;
                      }
                    });
                  },
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      child: const Text("Only Favorites"),
                      value: FilterOptions.Favorites,
                    ),
                    PopupMenuItem(
                      child: const Text("Show All"),
                      value: FilterOptions.All,
                    ),
                  ],
                ),
              ],
            ),
            drawer: screenWidth < 800 ? AppDrawer() : null,
            body: _isLoading
                ? const Center(
                    child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            const Color(0xff1E4E5F))),
                  )
                : ProductsGrid(_showOnlyFavorites),
          ),
        ),
      ],
    );
  }
}
