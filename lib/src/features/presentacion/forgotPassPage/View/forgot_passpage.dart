import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/presentacion/forgotPassPage/ViewModel/forgot_password_view_model.dart';
import 'package:app_delivery/src/features/presentacion/forgotPassPage/component/TextFormFieldForgotEmail.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Alertas/alert_dialog.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Botons/create_button.dart';
import 'package:flutter/material.dart';

import '../../widgets/BackBoton/back_button.dart';
import '../../widgets/Headers/header_text.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  //DEPENDENCIAS
  final ForgotPasswordViewModel _forgotPasswordViewModel;

  _ForgotPasswordState({ForgotPasswordViewModel? forgotPasswordViewModel})
      : _forgotPasswordViewModel =
            forgotPasswordViewModel ?? DefaultForgotPasswordViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Builder(builder: (BuildContext context) {
          return const BackButtonView(color: Colors.black);
        }),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              headerText(
                  texto: 'Restablecer contraseña',
                  color: Theme.of(context).primaryColor,
                  fontSize: 30.0),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: const Text('Ingresar tu correo electronico',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0)),
              ),
              TextFormFieldEmailUpdatePassword(
                  viewModel: _forgotPasswordViewModel),
              //_buttonSend(context)
              createButton(
                  context: context,
                  labelButton: "Enviar",
                  color: orange,
                  func: () => _ctaButtonTapped(context))
            ],
          ),
        ),
      ),
    );
  }
}

extension UserActions on _ForgotPasswordState {
  void _ctaButtonTapped(BuildContext context) {
    _forgotPasswordViewModel.updatePassword().then((value) {
      showAlertDialog(
          context,
          const AssetImage("assets/inicio.png"),
          "Restablecer contraseña",
          "Revise su corre",
          createButton(
              context: context,
              labelButton: "Hecho",
              color: orange,
              func: () {
                Navigator.pushNamed(context, "login");
              }));
    });

    // Agregar un pequeño retraso antes de navegar hacia atrás
  }
}
