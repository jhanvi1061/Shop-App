import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import '../providers/auth.dart';
import '../screens/user_products_screen.dart';
import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  String greet() {
    int time = DateTime.now().hour;
    return time < 12
        ? "Good Morning!"
        : time < 17
            ? "Good Afternoon!"
            : "Good Evening!";
  }

  @override
  Widget build(BuildContext context) {
    print("Build() - AppDrawer");
    return Drawer(
      child: Column(
        children: [
          AppBar(
            toolbarHeight: 48,
            title: Text(greet()),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(Icons.shop_outlined),
            title: const Text("Shop"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          const Divider(color: Colors.transparent),
          ListTile(
            leading: const Icon(Icons.payment_outlined),
            title: const Text("Orders"),
            onTap: () {
              // Navigator.of(context).pushReplacement(
              //   CustomRoute(
              //     builder: (context) => OrdersScreen(),
              //   ),
              // );
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          const Divider(color: Colors.transparent),
          ListTile(
            leading: const Icon(Icons.edit_outlined),
            title: const Text("Manage Products"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          const Divider(color: Colors.transparent),
          ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: Row(
              children: [
                const Text("Made with"),
                const Icon(Icons.favorite_rounded),
                const Text(" by"),
              ],
            ),
            subtitle: const Text(
              "Jhanvi Soni",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
          const Divider(color: Colors.transparent),
          ListTile(
            leading: const Icon(Icons.exit_to_app_outlined),
            title: const Text("Logout"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
