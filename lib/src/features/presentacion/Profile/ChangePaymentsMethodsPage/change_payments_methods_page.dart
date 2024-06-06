import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/Entidades/PaymentsMethods/payments_methods_entity.dart';
import 'package:app_delivery/src/features/presentacion/ErrorView/error_view.dart';
import 'package:app_delivery/src/features/presentacion/MainCordinator/MainCordinator.dart';
import 'package:app_delivery/src/features/presentacion/Profile/ChangePaymentsMethodsPage/components/change_payments_methods_content_view.dart';
import 'package:app_delivery/src/features/presentacion/Profile/ChangePaymentsMethodsPage/components/payments_methods_card.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/user_state_provider.dart';
import 'package:app_delivery/src/features/presentacion/widgets/BackBoton/back_button.dart';
import 'package:app_delivery/src/utils/extensions/screem_size.dart';
import 'package:app_delivery/src/utils/helpers/CheckoutHelper/check_out_helper.dart';
import 'package:app_delivery/src/utils/styles/box_decoration_shadow.dart';
import 'package:flutter/material.dart';

class ChangePaymentsMethodsPage extends StatefulWidget {
  const ChangePaymentsMethodsPage({Key? key}) : super(key: key);

  @override
  State<ChangePaymentsMethodsPage> createState() =>
      _ChangePaymentsMethodsPageState();
}

class _ChangePaymentsMethodsPageState extends State<ChangePaymentsMethodsPage>
    with BaseView, BaseViewStateDelegate {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FooterView(delegate: this),
        appBar: AppBar(
            title: const Text("Metodos de pago",
                style: TextStyle(fontSize: 17, color: Colors.black)),
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0.4,
            leading: Builder(
              builder: (BuildContext context) {
                return const BackButtonView(color: Colors.black);
              },
            )),
        body: FutureBuilder(
            future: (context).getPaymentMethods(),
            builder: (BuildContext context,
                AsyncSnapshot<PaymentMethodsEntity?> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  print("esperaando");
                  return loadingView;
                case ConnectionState.done:
                  if (snapshot.hasData && snapshot.data != null) {
                    return ChangePaymentsMethodsContentView(
                        paymentMethods: snapshot.data, delegate: this);
                  } else {
                    return ErrorView();
                  }
                default:
                  return loadingView;
              }
            }));
  }

  @override
  void onChange() {
    print("+++++++++ onChange");
    setState(() {});
  }
}

class FooterView extends StatelessWidget
    with BaseView, PaymentMethodCardViewDelegate {
  BaseViewStateDelegate? delegate;

  FooterView({Key? key, required this.delegate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getBoxDecorationWithShadows(),
      width: getScreenWidth(context: context),
      height: 220,
      margin: const EdgeInsets.only(left: 16, right: 16),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          PaymentMethodCardView(
              defaultTitle: 'Añadir nueva cuenta de Paypal',
              defaultPaymentMethod: PaymentMethodsTypes.paypal,
              delegate: this),
          PaymentMethodCardView(
              defaultTitle: 'Añadir nueva tarjeta Visa',
              defaultPaymentMethod: PaymentMethodsTypes.visa,
              delegate: this),
          PaymentMethodCardView(
              defaultTitle: 'Añadir nueva tarjeta Mastercard',
              defaultPaymentMethod: PaymentMethodsTypes.mastercard,
              delegate: this)
        ],
      ),
    );
  }

  @override
  paymentMethodTapped(
      {required BuildContext context,
      required PaymentMethodEntity? paymentMethod,
      required PaymentMethodsTypes type}) {
    switch (type) {
      case PaymentMethodsTypes.paypal:
        coordinator.showAddEditPaypalAccountPage(
            context: context, isForEditing: false, viewStateDelegate: delegate);
        break;
      case PaymentMethodsTypes.visa:
        coordinator.showAddEditCardPage(
            context: context,
            isForEditing: false,
            isForCreateAVisaCard: true,
            viewStateDelegate: delegate);
        break;
      case PaymentMethodsTypes.mastercard:
        coordinator.showAddEditCardPage(
            context: context,
            isForEditing: false,
            isForCreateAVisaCard: false,
            viewStateDelegate: delegate);
        break;
      default:
        break;
    }
  }
}
