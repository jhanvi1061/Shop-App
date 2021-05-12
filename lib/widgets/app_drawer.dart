import 'package:flutter/material.dart';

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
            title: Text(
              greet(),
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(Icons.shop_outlined),
            title: const Text("Shop"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment_outlined),
            title: const Text("Orders"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit_outlined),
            title: const Text("Manage Products"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: const Text("Developed by"),
            subtitle: const Text(
              "Jhanvi Soni",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
