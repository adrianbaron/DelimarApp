import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Alertas/AlertView/Model/alert_view_model.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Botons/rounded_botton.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/text_view.dart';
import 'package:flutter/material.dart';

class AlertView {
  static Future showAlertDialog({ required AlertViewModel model }) async {
      await showDialog(
          context: model.context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              content: SizedBox(
                height: 360,
                child: Column(
                  children: [
                    Image(
                      image: model.imagePath,
                      width: 130,
                      height: 130,
                    ),
                    Container(
                        margin: const EdgeInsets.all(15.0),
                        child: TextView(texto: model.headerTitle, color: Colors.orange, fontSize: 20.0)
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Text(model.headerSubTitle,
                          style: const TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.w400,
                              fontSize: 15.0)),
                    ),
                    createElevatedButton(
                      color: orange,
                      labelButton: model.ctaButtonText,
                      shape: const StadiumBorder(),
                      labelFontSize: 17,
                      func: model.ctaButtonAction
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: model.cancelTextAction,
                      child: TextView(texto: model.cancelText ?? "",
                                      color: gris, fontSize: 17, textAlign: TextAlign.center, fontWeight: FontWeight.w300))
                  ],
                ),
              ),
            );
          }
        );
  }

  static closeAlertDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
