import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/Entidades/Order/order_entity.dart';
import 'package:app_delivery/src/features/presentacion/MainCordinator/MainCordinator.dart';
import 'package:app_delivery/src/features/presentacion/OrderConfirmationPage/View/components/AddressAndPayment/address_and_payments.dart';
import 'package:app_delivery/src/features/presentacion/OrderConfirmationPage/View/components/CourierTipView/components/tip_view.dart';
import 'package:app_delivery/src/features/presentacion/OrderConfirmationPage/View/components/CourierTipView/courier_tip_view.dart';
import 'package:app_delivery/src/features/presentacion/OrderConfirmationPage/View/components/DeliveryDetailsView/delivery_details_view.dart';
import 'package:app_delivery/src/features/presentacion/OrderConfirmationPage/View/components/OrderDetailsView/order_details_view.dart';
import 'package:app_delivery/src/features/presentacion/OrderConfirmationPage/View/components/SummaryView/summary_view.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/user_state_provider.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Alertas/AlertView/Model/alert_view_model.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Alertas/AlertView/alert_view.dart';
import 'package:app_delivery/src/features/presentacion/widgets/BackBoton/back_button.dart';
import 'package:app_delivery/src/features/presentacion/widgets/FAB/fab_rounded_rectangle_view.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/text_view.dart';
import 'package:app_delivery/src/features/presentacion/widgets/ProductSelectedCardView/View/product_selected_card_view.dart';
import 'package:app_delivery/src/utils/helpers/CheckoutHelper/check_out_helper.dart';
import 'package:flutter/material.dart';

class OrderConfirmationPage extends StatefulWidget {
  OrderEntity order;

  OrderConfirmationPage({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderConfirmationPage> createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage>
    with
        ProductSelectedCardViewDelegate,
        BaseViewStateDelegate,
        CourierTipViewDelegate,
        DeliveryDetailsViewDelegate,
        BaseView {
  @override
  Widget build(BuildContext context) {
    _updateDeliveryAddressInOrder(context);
    _updatePaymentMethodInOrder(context);

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
              _showPurchaseSuccessAlert(context);
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
                  DeliveryAddressAndPaymentMethodsView(),
                  CourierTipView(delegate: this),
                  DeliveryDetailsView(
                    order: widget.order,
                    delegate: this,
                  ),
                  SummaryView(order: widget.order),
                  const SizedBox(height: 120)
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

      if (widget.order.products.isEmpty) {
        Navigator.pop(context, widget.order);
      }
    });
  }

  @override
  void onChange() {
    setState(() {});
  }

  @override
  courierTipChanged({required TipModel model}) {
    setState(() {
      widget.order.courierTip = model.tip;
      widget.order.updateTotalPrice();
    });
  }

  @override
  deliveryDetailsChanged({required OrderEntity order}) {
    widget.order = order;
  }
}

extension PrivateMethods on _OrderConfirmationPageState {
  Future<void> _updateDeliveryAddressInOrder(BuildContext context) async {
    try {
      var deliveryAdrress = await (context).getDeliveryAddressList();
      if (deliveryAdrress == null) {
        return;
      }
      widget.order.deliveryAddress =
          CheckoutHelper.getMainDeliveryAddress(entity: deliveryAdrress!)
              .deliveryAddressList
              .first;
    } catch (e) {
      // Manejar el error de una manera adecuada
      print('Error al obtener la dirección de entrega: $e');
    }
  }

  Future<void> _updatePaymentMethodInOrder(BuildContext context) async {
    try {
      var paymentMethods = await (context).getPaymentMethods();
      if (paymentMethods == null) {
        return;
      }
      widget.order.paymentMethod =
          CheckoutHelper.getMainPaymentMethods(entity: paymentMethods)
              .paymentMethods
              .first;
    } catch (e) {
      // Manejar el error de una manera adecuada
      print('Error al obtener la dirección de entrega: $e');
    }
  }
}

extension AlertsMethods on _OrderConfirmationPageState {
  _showPurchaseSuccessAlert(BuildContext context) {
    AlertView.showAlertDialog(
        model: AlertViewModel(
            context,
            const AssetImage('assets/check_order.png'),
            "Su pedido fue exitoso.",
            'Puedes realizar el seguimiento de la entrega en la sección "Mi orden".',
            "Continua comprando",
            "Ir a mi orden", () {
      // Cta Action
      coordinator.showTabsPage(context: context);
    }, () {
      // Subtitle Action
      coordinator.showTabsPage(context: context, selectedTab: 1);
    }));
  }

  _showFailureSuccessAlert(BuildContext context) {
    AlertView.showAlertDialog(
        model: AlertViewModel(
            context,
            const AssetImage('assets/cancelar.png'),
            "Tu pedido ha fallado.",
            'Podrás consultar el método de pago seleccionado.',
            "Continuar con el registro",
            "ir a mi orden", () {
      // Cta Action
      AlertView.closeAlertDialog(context);
    }, () {
      // Subtitle Action
      coordinator.showTabsPage(context: context, selectedTab: 1);
    }));
  }
}
