import 'dart:ui';

import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/presentacion/MainCordinator/MainCordinator.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/LoadingStatusStateProvider.dart';
import 'package:app_delivery/src/features/presentacion/welcomePage/ViewModel/welcome_page_view_model.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Botons/create_button.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/header_text.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with BaseView {
  final WelcomePageViewModel viewModel;

  _WelcomePageState({WelcomePageViewModel? welcomePageViewModel})
      : viewModel = welcomePageViewModel ?? DefaultWelcomePageViewModel();

  @override
  Widget build(BuildContext context) {
    //
    viewModel.initState(
        loadingState: Provider.of<LoadingStateProvider>(context));
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage("assets/home.png"))),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: headerText(
                  texto: 'Delicias del mar \n a tu hogar',
                  color: Colors.white,
                  fontSize: 50.0),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
              child: const Text(
                  "Te entregamos tu producto en la puerta de tu casa",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 17.0)),
            ),

            //aqui va el boton de inicio
            createButton(
                context: context,
                labelButton: "Iniciar sesion",
                color: orange,
                func: () {
                  Navigator.pushNamed(context, "login");
                }),

            //Aqui el otro boton
            createButton(
                context: context,
                labelButton: "Iniciar con google",
                color: Colors.white,
                isWithIcon: true,
                icon: const AssetImage("assets/google.png"),
                func: () {
                  _signInWithGoogleTapped(context);
                })
          ],
        )
      ]),
    );
  }
}

extension UserActions on _WelcomePageState {
  _signInWithGoogleTapped(BuildContext context) {
    viewModel.loadingStatusState.setLoadingState(isLoading: true);

    viewModel.signInWithGoogle().then((result) {
      switch (result.status) {
        case ResultStatus.success:
          coordinator.showTabsPage(context: context);
        case ResultStatus.error:
          viewModel.loadingStatusState.setLoadingState(isLoading: true);
          if (result.error == null) {
            return;
          }
          errorStateProvider.setFailure(context: context, value: result.error!);
      }
    });
  }
}
