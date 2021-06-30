import 'package:intl/intl.dart';

import 'dart:math';
import 'package:flutter/material.dart';

import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    print("Build() - OrderItem");
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height:
          _expanded ? min(widget.order.products.length * 20.0 + 110, 200) : 95,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              tileColor: const Color(0xffFFFAF4),
              title: Text("\$${widget.order.amount}"),
              subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.datetTime),
              ),
              trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() => _expanded = !_expanded);
                },
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: _expanded
                  ? min(widget.order.products.length * 20.0 + 110, 200)
                  : 0,
              child: Container(
                color: const Color(0xffFFFAF4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                // height: min(widget.order.products.length * 20.0 + 110, 200),
                child: ListView(
                  children: widget.order.products
                      .map((prod) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                prod.title,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "${prod.quantity}x \$${prod.price}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
