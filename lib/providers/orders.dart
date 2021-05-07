import 'package:flutter/foundation.dart';

import '../providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime datetTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.datetTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders => [..._orders];

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        datetTime: DateTime.now(),
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
