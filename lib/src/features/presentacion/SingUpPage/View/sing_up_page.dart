import 'package:app_delivery/src/Base/Views/BaseView.dart';

import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/presentacion/MainCordinator/MainCordinator.dart';
import 'package:app_delivery/src/features/presentacion/SingUpPage/ViewModel/SingUpViewModel.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/LoadingStatusStateProvider.dart';
import 'package:app_delivery/src/features/presentacion/widgets/BackBoton/back_button.dart';

import 'package:app_delivery/src/features/presentacion/widgets/Botons/rounded_botton.dart';

import 'package:app_delivery/src/features/presentacion/widgets/Headers/text_view.dart';
import 'package:app_delivery/src/features/presentacion/widgets/TextFormField/CustonTextFormField.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget with BaseView {
  final SignUpViewModel _viewModel;

  SignUpPage({SignUpViewModel? viewModel})
      : _viewModel = viewModel ?? DefaultSignUpViewModel();

  @override
  Widget build(BuildContext context) {
    // Init ViewModel
    _viewModel.initState(
        loadingState: Provider.of<LoadingStateProvider>(context));

    return _viewModel.loadingStatusState.isLoading
        ? loadingView
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              leading: Builder(builder: (BuildContext context) {
                return const BackButtonView(color: Colors.black);
              }),
            ),
            body: CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildListDelegate([
                  Center(
                    child: Form(
                      key: _viewModel.formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: [
                            const TextView(
                                texto: 'Crear una cuenta',
                                color: Colors.orange,
                                fontSize: 30.0),
                            CustomTextFormField(
                                delegate: _viewModel,
                                hintext: 'Username',
                                textFormFieldType:
                                    CustomTextFormFieldType.username),
                            CustomTextFormField(
                                delegate: _viewModel,
                                hintext: 'Email',
                                textFormFieldType:
                                    CustomTextFormFieldType.email),
                            CustomTextFormField(
                                delegate: _viewModel,
                                hintext: 'Phone',
                                textFormFieldType:
                                    CustomTextFormFieldType.phone),
                            GestureDetector(
                                onTap: () => _selectDate(context),
                                child: AbsorbPointer(
                                    child: CustomTextFormField(
                                        delegate: _viewModel,
                                        hintext: 'Date of Birth',
                                        textFormFieldType:
                                            CustomTextFormFieldType.dateOfBirth,
                                        controller:
                                            _viewModel.dateController))),
                            CustomTextFormField(
                                delegate: _viewModel,
                                hintext: 'Password',
                                textFormFieldType:
                                    CustomTextFormFieldType.password),
                            createElevatedButton(
                                color: orange,
                                labelButton: 'Sign up',
                                shape: const StadiumBorder(),
                                func: () => ctaTapped(context)),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 40.0),
                                child: const Text(
                                    'Al hacer clic en Registrarse aceptas los siguientes Términos y Condiciones sin reservas',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.0)))
                          ],
                        ),
                      ),
                    ),
                  )
                ]))
              ],
            ),
          );
  }
}

// User Actions
extension UserActions on SignUpPage {
  ctaTapped(BuildContext context) {
    if (_viewModel.isFormValidate()) {
      _viewModel.signUp().then((result) {
        switch (result.status) {
          case ResultStatus.success:
            coordinator.showTabsPage(context: context);
            break;
          case ResultStatus.error:
            errorStateProvider.setFailure(
                context: context, value: result.error!);
            break;
        }
      });
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _viewModel.selectedDate,
        firstDate: DateTime(1960, 1),
        lastDate: DateTime(2100),
        locale: const Locale('es', ''));

    if (picked != null && picked != _viewModel.selectedDate) {
      _viewModel.signUpModel?.date =
          "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
      _viewModel.dateController.text =
          "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
    }
  }
}
