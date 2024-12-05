import 'package:flutter/material.dart';

import '../Headers/header_text.dart';

showAlertDialog(BuildContext context, ImageProvider<Object> imagePath,
    String title, String subTitle, Widget bottonDone) async {
  await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: SizedBox(
            height: 300,
            child: Column(
              children: [
                Image(
                  image: imagePath,
                  width: 130,
                  height: 130,
                ),
                Container(
                  margin: const EdgeInsets.all(15.0),
                  child: headerText(
                      texto: title,
                      color: Theme.of(context).primaryColor,
                      fontSize: 20.0),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: Text(subTitle,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 15.0)),
                ),
                bottonDone
              ],
            ),
          ),
        );
      });
}
