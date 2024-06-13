import 'package:app_delivery/src/features/logica/Entidades/Order/order_entity.dart';
import 'package:app_delivery/src/utils/helpers/CheckoutHelper/check_out_helper.dart';
import 'package:app_delivery/src/utils/styles/box_decoration_shadow.dart';
import 'package:flutter/material.dart';

class SummaryView extends StatelessWidget {
  OrderEntity order;

  SummaryView({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: getBoxDecorationWithShadows(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("RESUMEN",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Container(
              margin: const EdgeInsets.only(top: 12),
              child: Divider(color: Colors.black.withOpacity(0.3))),
          Container(
            margin: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Productos",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                Text(CheckoutHelper.formatPriceInEuros(order.totalAmount),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Iva",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                Text(CheckoutHelper.formatPriceInEuros(order.fee),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Domicilio",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                Text(CheckoutHelper.formatPriceInEuros(order.deliveryFee),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600))
              ],
            ),
          ),
          order.hasCourierTip()
              ? Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Propina",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400)),
                      Text(CheckoutHelper.formatPriceInEuros(order.courierTip),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600))
                    ],
                  ),
                )
              : Container(),
          Container(
            margin: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(CheckoutHelper.formatPriceInEuros(order.totalAmountToPay),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold))
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 12),
              child: Divider(color: Colors.black.withOpacity(0.3))),
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 16),
            child: const Text(
                "Los mensajeros ganan entre 4 y 5 mil pesos de media por cada pedido que entregan, más propinas.",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
          ),
        ],
      ),
    );
  }
}
