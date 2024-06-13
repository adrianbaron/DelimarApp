import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/presentacion/OrderConfirmationPage/View/components/AddressAndPayment/components/delivery_address_view.dart';
import 'package:app_delivery/src/features/presentacion/OrderConfirmationPage/View/components/AddressAndPayment/components/payment_methods_view.dart';
import 'package:app_delivery/src/utils/styles/box_decoration_shadow.dart';
import 'package:flutter/material.dart';

class DeliveryAddressAndPaymentMethodsView extends StatelessWidget {
  final BaseViewStateDelegate? viewStateDelegate;

  DeliveryAddressAndPaymentMethodsView({Key? key, this.viewStateDelegate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: getBoxDecorationWithShadows(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DeliveryAddressView(viewStateDelegate: viewStateDelegate),
          PaymentMethodsView(viewStateDelegate: viewStateDelegate),

          const SizedBox(height: 18)
        ],
      ),
    );
  }
}
