import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../providers/cart.dart' show Cart;
import '../providers/orders.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    print("Build() - CartScreen");
    final cart = Provider.of<Cart>(context);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    return Row(
      children: [
        if (screenWidth > 800) ...{AppDrawer()},
        Expanded(
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 48,
              title: const Text("Your Cart"),
            ),
            body: Column(
              children: [
                Card(
                  margin: const EdgeInsets.all(15),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total",
                          style: const TextStyle(fontSize: 20),
                        ),
                        const Spacer(),
                        Chip(
                          label: Text(
                            "\$${cart.totalAmount.toStringAsFixed(2)}",
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .headline6
                                  .color,
                            ),
                          ),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        OrderButton(cart: cart),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                cart.items.length == 0
                    ? const Center(child: const Text("Your Cart is empty"))
                    : Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: cart.items.length,
                          itemBuilder: (context, i) => CartItem(
                            id: cart.items.values.toList()[i].id,
                            productId: cart.items.keys.toList()[i],
                            title: cart.items.values.toList()[i].title,
                            quantity: cart.items.values.toList()[i].quantity,
                            price: cart.items.values.toList()[i].price,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class OrderButton extends StatefulWidget {
  final Cart cart;

  const OrderButton({@required this.cart});

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: _isLoading
          ? const CircularProgressIndicator(
              strokeWidth: 1.5,
              valueColor:
                  AlwaysStoppedAnimation<Color>(const Color(0xff1E4E5F)),
            )
          : Text(
              "ORDER NOW",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() => _isLoading = true);
              await Provider.of<Orders>(context, listen: false).addOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalAmount,
              );
              setState(() => _isLoading = false);
              widget.cart.clear();
            },
    );
  }
}
