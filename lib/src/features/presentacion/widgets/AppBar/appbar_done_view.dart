import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/presentacion/widgets/BackBoton/back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget? createAppBarDone(
    {required String title,
    required String actionText,
    required Function()? onTap}) {
  return AppBar(
    title:
        Text(title, style: const TextStyle(fontSize: 17, color: Colors.black)),
    backgroundColor: Colors.white,
    elevation: 0.4,
    leading: Builder(
      builder: (BuildContext context) {
        return const BackButtonView(color: Colors.black);
      },
    ),
    actions: [
      GestureDetector(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.only(top: 20, right: 15.0),
            child: Text(actionText,
                style: TextStyle(
                    color: orange,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500))),
      )
    ],
  );
}

// updateUserData();