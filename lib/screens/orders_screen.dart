import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // var _isLoading = false;

  // @override
  // void initState() {
  //   Future.delayed(Duration.zero).then((_) async {
  //     setState(() => _isLoading = true);
  //     await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  //     setState(() => _isLoading = false);
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    print("Build() - OrdersScreen");
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    // final orderData = Provider.of<Orders>(context);
    return Row(
      children: [
        if (screenWidth > 800) ...{AppDrawer()},
        Expanded(
          child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 48,
                title: const Text(
                  "Your Orders",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              drawer: screenWidth < 800 ? AppDrawer() : null,
              body: FutureBuilder(
                future: Provider.of<Orders>(context, listen: false)
                    .fetchAndSetOrders(),
                builder: (context, dataSnapshot) {
                  if (dataSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (dataSnapshot.error != null) {
                      return Center(
                        child: const Text("An error occurred!"),
                      );
                    } else {
                      return Consumer<Orders>(
                        builder: (context, orderData, child) =>
                            ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: orderData.orders.length,
                          itemBuilder: (context, i) =>
                              OrderItem(orderData.orders[i]),
                        ),
                      );
                    }
                  }
                },
              )
              // _isLoading
              //     ? Center(child: CircularProgressIndicator())
              //     : ListView.builder(
              //         physics: BouncingScrollPhysics(),
              //         itemCount: orderData.orders.length,
              //         itemBuilder: (context, i) => OrderItem(orderData.orders[i]),
              //       ),
              ),
        ),
      ],
    );
  }
}
