import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:shop_app/providers/auth.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // const ProductItem({this.id, this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    print("Build() - ProductItem");
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              placeholder: AssetImage('assets/product-placeholder.png'),
              image: NetworkImage(product.imageUrl),
              imageErrorBuilder: (context, error, stackTrace) =>
                  Image.asset('assets/product-placeholder.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: const Color(0xff021639).withOpacity(0.8),
          leading: Consumer<Product>(
            builder: (context, product, _) => IconButton(
              color: Color(0xffFFB156),
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 21,
              ),
              onPressed: () =>
                  product.toggleFavoriteStatus(authData.token, authData.userId),
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13),
          ),
          trailing: IconButton(
            color: Theme.of(context).accentColor,
            icon: const Icon(Icons.shopping_cart_outlined, size: 21),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Added item to cart!"),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: "UNDO",
                    onPressed: () => cart.removeSingleItem(product.id),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
