import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:shop_app/providers/products_provider.dart';

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
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Future.delayed(Duration.zero).then(
    //   (_) => Provider.of<ProductsProvider>(context).fetchAndSetProducts(),
    // );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() => _isLoading = true);
      Provider.of<ProductsProvider>(context).fetchAndSetProducts().then((_) {
        setState(() => _isLoading = false);
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("Build() - ProductsOverviewScreen");
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    return Row(
      children: [
        if (screenWidth > 600) ...{
          AppDrawer(),
          const VerticalDivider(
            width: 0.1,
          ),
        },
        Expanded(
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 48,
              title: const Text(
                "MeShop",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
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
                  color: Color(0xffFFF7EE),
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
            drawer: screenWidth < 600 ? AppDrawer() : null,
            body: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ProductsGrid(_showOnlyFavorites),
          ),
        ),
      ],
    );
  }
}
