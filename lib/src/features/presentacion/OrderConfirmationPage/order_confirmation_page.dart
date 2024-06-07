import 'package:app_delivery/src/features/logica/Entidades/Order/order_entity.dart';
import 'package:flutter/material.dart';

class OrderConfirmationPage extends StatefulWidget {
  OrderEntity order;
  OrderConfirmationPage({ Key? key , required this.order }) : super(key: key);

  @override
  State<OrderConfirmationPage> createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red);
  }
}
