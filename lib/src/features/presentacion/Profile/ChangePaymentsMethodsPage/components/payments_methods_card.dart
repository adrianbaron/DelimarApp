import 'package:app_delivery/src/features/logica/Entidades/PaymentsMethods/payments_methods_entity.dart';
import 'package:app_delivery/src/utils/helpers/CheckoutHelper/check_out_helper.dart';
import 'package:app_delivery/src/utils/styles/box_decoration_shadow.dart';
import 'package:flutter/material.dart';
class PaymentMethodCardsView extends StatelessWidget {

  final PaymentMethodsEntity? paymentMethods;
  final PaymentMethodCardViewDelegate? delegate;

  const PaymentMethodCardsView({ Key? key,
                                 required this.paymentMethods,
                                 this.delegate }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: getPaymentMethodsCard(),
    );
  }

  List<Widget> getPaymentMethodsCard() {
    if (paymentMethods == null) { return []; }

    return paymentMethods?.paymentMethods.map( (paymentMethod) {
      return PaymentMethodCardView(paymentMethod: paymentMethod,
                                   delegate: delegate,
                                   defaultPaymentMethod: PaymentMethodsTypes.values.byName(paymentMethod.type));
    }).toList() ?? [];
  }
}

mixin PaymentMethodCardViewDelegate {
  paymentMethodTapped({ required BuildContext context,
                        required PaymentMethodEntity? paymentMethod,
                        required PaymentMethodsTypes type });
}

class PaymentMethodCardView extends StatelessWidget {

  String? defaultTitle;
  PaymentMethodsTypes defaultPaymentMethod;
  PaymentMethodEntity? paymentMethod;
  bool isMainPaymentMethod;
  Decoration? decoration;
  PaymentMethodCardViewDelegate? delegate;

  PaymentMethodCardView({ Key? key,
                          required this.defaultPaymentMethod,
                          this.paymentMethod,
                          this.defaultTitle,
                          this.isMainPaymentMethod = false,
                          this.decoration,
                          this.delegate }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        delegate?.paymentMethodTapped(paymentMethod: paymentMethod,
                                      context: context,
                                      type: defaultPaymentMethod);
      },
      child: Container(
        decoration: decoration ?? borderSideNoneGrayBackgroundDecoration,
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(image: AssetImage(getAssetImageName()),
                  width: 26,
                  height: 26),
            Text(getCardTitle(),
                 style: const TextStyle(
                  fontSize: 17
                 )),
            isMainPaymentMethod ?
                const Image(image: AssetImage("assets/check_order_fill.png"),
                      width: 26,
                      height: 26)
                : Container()
          ],
        ),
      ),
    );
  }

  String getCardTitle() {
    if (defaultTitle == null) {
      return paymentMethod?.type == PaymentMethodsTypes.paypal.name ? paymentMethod?.email ?? ""
            : CheckoutHelper.obfuscateCardNumber(paymentMethod?.cardNumber ?? "");
    } else {
      return defaultTitle ?? "";
    }
  }

  String getAssetImageName() {
    return CheckoutHelper.getPaymentMethodAssetImage(paymentMethod: defaultPaymentMethod);
  }
}
