import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/logica/Entidades/DeliveryAddress/delivery_address_entity.dart';
import 'package:app_delivery/src/features/presentacion/ErrorView/error_view.dart';
import 'package:app_delivery/src/features/presentacion/MainCordinator/MainCordinator.dart';
import 'package:app_delivery/src/features/presentacion/Profile/ChangeDeliveryAddressPage/components/change_delivery_address_content_view.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/user_state_provider.dart';
import 'package:flutter/material.dart';

import '../../widgets/BackBoton/back_button.dart';
import '../../widgets/FAB/fab_rounded_rectangle_view.dart';

class ChangeDeliveryAddressPage extends StatefulWidget {
  const ChangeDeliveryAddressPage({Key? key}) : super(key: key);

  @override
  State<ChangeDeliveryAddressPage> createState() =>
      _ChangeDeliveryAddressPageState();
}

class _ChangeDeliveryAddressPageState extends State<ChangeDeliveryAddressPage>
    with BaseView, BaseViewStateDelegate {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FABRoundedRectangleView(
          text: 'Agregar una nueva direccion',
          backgroundColor: orange,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          onPressed: () {
            coordinator.showAddEditDeliveryAddress(
                context: context, viewStateDelegate: this, isForEditing: false);
          },
          isHidden: false),
      appBar: AppBar(
          title: const Text("Directorio",
              style: TextStyle(fontSize: 17, color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 0.4,
          leading: Builder(
            builder: (BuildContext context) {
              return const BackButtonView(color: Colors.black);
            },
          )),
      body: FutureBuilder(
          future: (context).getDeliveryAddressList(),
          builder: (BuildContext context,
              AsyncSnapshot<DeliveryAddressListEntity?> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return loadingView;
              case ConnectionState.done:
                if (snapshot.hasData && snapshot.data != null) {
                  return ChangeDeliveryAddressContentView(
                      deliveryAddressEntity: snapshot.data,
                      viewStateDelegate: this);
                } else {
                  return ErrorView();
                }
              default:
                return loadingView;
            }
          }),
    );
  }

  @override
  void onChange() {
    print("onChange ++++++++++");
    setState(() {});
  }
}
