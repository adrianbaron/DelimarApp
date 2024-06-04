import 'package:flutter/material.dart';

class ErrorAlertView {
  static Future<void> showErrorAlertDialog({
    required BuildContext context,
    required String subtitle,
    dynamic Function()? ctaButtonAction,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white10,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 30, vertical: 64), // Ajuste de altura
          content: SizedBox(
            height: 250, // Ajuste de altura
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Image(
                  image: AssetImage('assets/cancelar.png'),
                  width: 100,
                  height: 100,
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: const Text(
                    "Error",
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: ctaButtonAction,
                  child: const Text('Ir a inicio'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.orange),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
