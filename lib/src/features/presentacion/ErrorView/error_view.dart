import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Botons/create_button.dart';
import 'package:app_delivery/src/utils/extensions/screem_size.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget with BaseView {
  bool isLocationDeniedError = false;
  String assetImagePath = "";
  String errorTitle = "";
  String errorSubTitle = "";

  ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    setErrorViewData();
    return Scaffold(
      backgroundColor: bgGrey,
      body: Center(
        child: Container(
          padding: EdgeInsets.only(
              top: getScreenHeight(context: context, multiplier: 0.1),
              bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(width: 216, height: 216, image: AssetImage(assetImagePath)),
              Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    errorTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: gris, fontSize: 15, fontWeight: FontWeight.bold),
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    errorSubTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: gris, fontSize: 12, fontWeight: FontWeight.w500),
                  )),
              const Spacer(),
              createButton(
                  context: context,
                  width: 300,
                  labelButton: isLocationDeniedError
                      ? "Establecer direccion de entrega"
                      : "Ir a inicio",
                  color: orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  func: () {
                    if (isLocationDeniedError) {
                      // TODO: Crear feature de añadir dirección de entrega
                    } else {
                      coordinator.showTabsPage(context: context);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  setErrorViewData() {
    assetImagePath =
        isLocationDeniedError ? 'assets/mapa.png' : 'assets/cancelar.png';
    errorTitle =
        isLocationDeniedError ? 'Location Denied Error' : 'Network Error';
    errorSubTitle = isLocationDeniedError
        ? 'Something bad happened, Without your current location, the app cannot continue to work properly. \n\n You can order anything, just indicate in which direction'
        : 'Something bad happened, the app cannot continue to work properly.';
  }
}
