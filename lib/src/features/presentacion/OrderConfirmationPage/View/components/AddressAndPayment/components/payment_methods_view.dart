import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/Colors/Colors.dart';
import 'package:app_delivery/src/features/logica/Entidades/PaymentsMethods/payments_methods_entity.dart';
import 'package:app_delivery/src/features/presentacion/MainCordinator/MainCordinator.dart';
import 'package:app_delivery/src/features/presentacion/Profile/ChangePaymentsMethodsPage/components/payments_methods_card.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/user_state_provider.dart';
import 'package:app_delivery/src/utils/helpers/CheckoutHelper/check_out_helper.dart';
import 'package:flutter/material.dart';

mixin PaymentMethodsDelegate {
  mainPaymentMethodChanged();
}

class PaymentMethodsView extends StatefulWidget {
  final BaseViewStateDelegate? viewStateDelegate;

  const PaymentMethodsView({Key? key, this.viewStateDelegate})
      : super(key: key);

  @override
  State<PaymentMethodsView> createState() => _PaymentMethodsViewState();
}

class _PaymentMethodsViewState extends State<PaymentMethodsView>
    with
        BaseView,
        PaymentMethodCardViewDelegate,
        PaymentMethodCardViewDelegate {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: (context).getPaymentMethods(),
      builder: (BuildContext context,
          AsyncSnapshot<PaymentMethodsEntity?> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          if (snapshot.data?.hasPaymentMethods() ?? false) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 16, top: 16),
                    child: const Text("METODO DE PAGO",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold))),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: _getProductCardsViews(
                        paymentMethodsEntity:
                            CheckoutHelper.getMainPaymentMethods(
                                entity: snapshot.data!)),
                  ),
                ),
                Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        coordinator
                            .showChangePaymentsMethodsPage(context: context)
                            .then((_) {
                          setState(() {
                            widget.viewStateDelegate?.onChange();
                          });
                        });
                      },
                      child: Container(
                          margin: const EdgeInsets.only(right: 16, top: 16),
                          child: Text("Editar metodo de pago",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: rosa))),
                    )
                  ],
                ),
                const SizedBox(height: 16)
              ],
            );
          } else {
            return Container(color: Colors.white);
          }
        } else {
          return Container(color: Colors.white);
        }
      },
    );
  }

  @override
  paymentMethodTapped(
      {required BuildContext context,
      required PaymentMethodEntity? paymentMethod,
      required PaymentMethodsTypes type}) {}

  @override
  selectMainPaymentMethodTapped(
      {required BuildContext context,
      required PaymentMethodEntity? paymentMethod}) {}

  List<Widget> _getProductCardsViews(
      {required PaymentMethodsEntity? paymentMethodsEntity}) {
    if (paymentMethodsEntity == null) {
      return [];
    }

    return paymentMethodsEntity.paymentMethods.map((paymentMethod) {
      return PaymentMethodCardView(
          paymentMethod: paymentMethod,
          delegate: this,
          defaultPaymentMethod:
              PaymentMethodsTypes.values.byName(paymentMethod.type));
    }).toList();
  }
}
