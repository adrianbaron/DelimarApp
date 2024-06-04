import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/LoadingStatusStateProvider.dart';
import 'package:app_delivery/src/features/presentacion/loginPage/ViewModel/login_view_model.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Botons/create_button.dart';
import 'package:app_delivery/src/features/presentacion/widgets/TextFormField/CustonTextFormField.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget with BaseView {
  //DEPENDENCIA
  final LoginViewModel _viewModel;

  //INICIALIZAR VIEW MODEL
  LoginPage({super.key, LoginViewModel? viewModel})
      : _viewModel = viewModel ?? DefaultLoginViewModel();
  @override
  Widget build(BuildContext context) {
    _viewModel.initState(
        loadingStateProvider: Provider.of<LoadingStateProvider>(context));
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white));

    return _viewModel.loadingState.isLoading
        ? loadingView
        : Scaffold(
            body: CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildListDelegate([
                Column(
                  children: [
                    const Stack(
                      children: [
                        Image(
                          width: double.infinity,
                          height: 300.0,
                          fit: BoxFit.cover,
                          image: AssetImage("assets/inicio.png"),
                        ),
                      ],
                    ),
                    Transform.translate(
                      offset: const Offset(0.0, -20.0),
                      child: Container(
                        width: double.infinity,
                        height: 500,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: Form(
                              key: _viewModel.formkey,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: Column(
                                children: [
                                  Text("Bienvenido",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30.0)),
                                  Text(
                                      "Inicia sesion con una cuenta o crea una",
                                      style: TextStyle(
                                          color: gris,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15.0)),
                                  //Texfield
                                  CustonTextFormField(
                                      textFormFieldType:
                                          CustonTextFormFieldType.email,
                                      hintext: "Email",
                                      delegate: _viewModel),
                                  CustonTextFormField(
                                      textFormFieldType:
                                          CustonTextFormFieldType.password,
                                      hintext: "Password",
                                      delegate: _viewModel),

                                  //_buttonLogin(context),
                                  createButton(
                                      context: context,
                                      labelButton: "Log in",
                                      color: orange,
                                      func: () {
                                        _ctaButtonTapped(context);
                                      }),
                                  Container(
                                    margin: const EdgeInsets.only(top: 30.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, 'forgot-pass');
                                      },
                                      child: const Text(
                                          'Has olvidado tu contraseña?',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 17.0)),
                                    ),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(top: 30.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('Aun no tienes una cuenta?',
                                              style: TextStyle(
                                                  color: gris,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15.0)),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, 'singUp');
                                            },
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: const Text(
                                                  'Crea una cuenta',
                                                  style: TextStyle(
                                                      color: Colors.orange,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15.0)),
                                            ),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ]))
            ],
          ));
  }
}

Widget _emailInput() {
  return Container(
    margin: const EdgeInsets.only(top: 40.0),
    padding: const EdgeInsets.only(left: 20.0),
    decoration: BoxDecoration(
        color: const Color.fromRGBO(142, 142, 147, 1.2),
        borderRadius: BorderRadius.circular(30.0)),
    child: const TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'Correo',
          border: OutlineInputBorder(borderSide: BorderSide.none)),
    ),
  );
}

Widget _PasswordInput() {
  return Container(
    margin: const EdgeInsets.only(top: 15.0),
    padding: const EdgeInsets.only(left: 20.0),
    decoration: BoxDecoration(
        color: const Color.fromRGBO(142, 142, 147, 1.2),
        borderRadius: BorderRadius.circular(30.0)),
    child: const TextField(
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Contraseña',
          border: OutlineInputBorder(borderSide: BorderSide.none)),
    ),
  );
}

Widget _buttonLogin(BuildContext context) {
  return Container(
    width: 350.0,
    height: 45.0,
    margin: const EdgeInsets.only(top: 30.0),
    child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, 'tabs');
        },
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.orangeAccent),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: const BorderSide(color: Colors.orangeAccent),
              ),
            )),
        child: const Text('Iniciar sesion',
            style: TextStyle(color: Colors.white, fontSize: 17.0))),
  );
}

extension UserActions on LoginPage {
  void _ctaButtonTapped(BuildContext context) {
    if (_viewModel.isFormValidate()) {
      _viewModel
          .login(
              email: _viewModel.loginModel?.email ?? "",
              password: _viewModel.loginModel?.password ?? "")
          .then((result) {
        switch (result.status) {
          case ResultStatus.success:
            Navigator.popAndPushNamed(context, "tabs");
          case ResultStatus.error:
            if (result.error != null) {
              errorStateProvider.setFailure(
                  context: context, value: result.error!);
            }
        }
      });
    }
  }
}
