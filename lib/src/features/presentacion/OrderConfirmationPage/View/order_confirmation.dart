import 'package:app_delivery/src/features/logica/Entidades/Order/order_entity.dart';
import 'package:app_delivery/src/features/presentacion/OrderConfirmationPage/View/components/order_details_view.dart';
import 'package:app_delivery/src/features/presentacion/widgets/BackBoton/back_button.dart';
import 'package:app_delivery/src/features/presentacion/widgets/FAB/fab_rounded_rectangle_view.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/text_view.dart';
import 'package:app_delivery/src/features/presentacion/widgets/ProductSelectedCardView/View/product_selected_card_view.dart';
import 'package:flutter/material.dart';

class OrderConfirmationPage extends StatefulWidget {
  OrderEntity order;

  OrderConfirmationPage({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderConfirmationPage> createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage>
    with ProductSelectedCardViewDelegate {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.4,
          leading: Builder(
            builder: (BuildContext context) {
              return BackButtonView(
                  color: Colors.black,
                  onPressed: () => Navigator.pop(context, widget.order));
            },
          ),
          backgroundColor: Colors.white,
          title: const TextView(
              texto: 'Confirmar orden',
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w600),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FABRoundedRectangleView(
            text: 'Confirmar orden',
            onPressed: () {
              // Todo: Create feature for confirm order
            },
            isHidden: false,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))),
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  // Todo: Create feature for confirm order
                  OrderDetailsView(order: widget.order, delegate: this),
                ],
              ),
            ),
          ],
        ));
  }

  @override
  updateAmount({required String productId, required int amount}) {
    List<ProductOrderEntity> products = widget.order.products.map((product) {
      var newProduct = product;
      if (newProduct.id == productId) {
        newProduct.amount += amount;
      }
      return newProduct;
    }).toList();

    //
    products.removeWhere((product) => product.amount == 0);
    setState(() {
      widget.order.products = products;
      widget.order.updateTotalPrice();

      if(widget.order.products.isEmpty){
        Navigator.pop(context, widget.order);
      }
    });
  }
}
 