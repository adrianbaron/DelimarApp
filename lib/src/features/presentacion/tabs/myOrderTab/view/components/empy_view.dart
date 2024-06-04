import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/header_text.dart';
import 'package:flutter/material.dart';

class EmpyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGrey,
      appBar: AppBar(
        elevation: 0.5,
        leading: const Text(""),
        backgroundColor: Colors.white,
        title: headerText(
            texto: "Mi pedido",
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 17),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              width: 216,
              height: 216,
              image: AssetImage('assets/canasta.png'),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: headerText(
                  texto: "Canasta vacia",
                  color: gris,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.only(top: 20.0),
              child: headerText(
                  texto:
                      "Disfruta de los mejores platos del mar, vamos animate a probar algo nuevo",
                  textAlign: TextAlign.center,
                  color: gris,
                  fontWeight: FontWeight.w500,
                  fontSize: 17),
            )
          ],
        ),
      ),
    );
  }
}
