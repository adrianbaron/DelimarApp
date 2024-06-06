import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/Entidades/PaymentsMethods/payments_methods_entity.dart';
import 'package:app_delivery/src/features/presentacion/MainCordinator/MainCordinator.dart';
import 'package:app_delivery/src/features/presentacion/Profile/ChangePaymentsMethodsPage/components/payments_methods_card.dart';
import 'package:app_delivery/src/utils/extensions/screem_size.dart';
import 'package:app_delivery/src/utils/helpers/CheckoutHelper/check_out_helper.dart';
import 'package:app_delivery/src/utils/styles/box_decoration_shadow.dart';
import 'package:flutter/material.dart';

class ChangePaymentsMethodsContentView extends StatelessWidget with BaseView {
  final PaymentMethodsEntity? paymentMethods;
  BaseViewStateDelegate? delegate;

  ChangePaymentsMethodsContentView(
      {Key? key, required this.paymentMethods, required this.delegate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          const SizedBox(height: 16),
          paymentMethods?.hasPaymentMethods() ?? false
              ? PaymentCardsView(
                  paymentMethods: paymentMethods, delegate: delegate)
              : Container()
        ]))
      ],
    );
  }
}

class PaymentCardsView extends StatelessWidget
    with BaseView, PaymentMethodCardViewDelegate {
  final PaymentMethodsEntity? paymentMethods;
  BaseViewStateDelegate? delegate;

  PaymentCardsView(
      {Key? key, required this.paymentMethods, required this.delegate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getBoxDecorationWithShadows(),
      width: getScreenWidth(context: context),
      margin: const EdgeInsets.only(left: 16, right: 16),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text("Estos son tu metodos de pago",
              style: TextStyle(fontSize: 15, color: Colors.orange)),
          const SizedBox(height: 20),
          PaymentMethodCardsView(
              paymentMethods: paymentMethods, delegate: this),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  @override
  paymentMethodTapped(
      {required BuildContext context,
      required PaymentMethodEntity? paymentMethod,
      required PaymentMethodsTypes type}) {
    switch (paymentMethod?.type) {
      case "paypal":
        coordinator.showAddEditPaypalAccountPage(
            context: context,
            isForEditing: true,
            paymentMethod: paymentMethod,
            viewStateDelegate: delegate);

      case "visa":
        coordinator.showAddEditCardPage(
            context: context,
            isForEditing: true,
            isForCreateAVisaCard: false,
            paymentMethod: paymentMethod,
            viewStateDelegate: delegate);

      case "mastercard":
        coordinator.showAddEditCardPage(
            context: context,
            isForEditing: true,
            isForCreateAVisaCard: false,
            paymentMethod: paymentMethod,
            viewStateDelegate: delegate);

      default:
        break;
    }
  }
}
