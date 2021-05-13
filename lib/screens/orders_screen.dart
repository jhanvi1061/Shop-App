import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    print("Build() - OrdersScreen");
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        title: const Text(
          "Your Orders",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: orderData.orders.length,
        itemBuilder: (context, i) => OrderItem(orderData.orders[i]),
      ),
    );
  }
}
