import 'package:app_delivery/src/Base/Views/BaseView.dart';

import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/presentacion/SingUpPage/ViewModel/SingUpViewModel.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/LoadingStatusStateProvider.dart';
import 'package:app_delivery/src/features/presentacion/widgets/BackBoton/back_button.dart';

import 'package:app_delivery/src/features/presentacion/widgets/Botons/create_button.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/header_text.dart';
import 'package:app_delivery/src/features/presentacion/widgets/TextFormField/CustonTextFormField.dart';
import 'package:app_delivery/src/utils/helpers/ResultType/resultType.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingUpPage extends StatelessWidget with BaseView {
  final SingUpViewModel _viewModel;
  SingUpPage({super.key, SingUpViewModel? viewModel})
      : _viewModel = viewModel ?? DefaultSingUpViewModel();
  @override
  Widget build(BuildContext context) {
    _viewModel.initState(
        loadingStateProvider: Provider.of<LoadingStateProvider>(context));
    return _viewModel.loadingState.isLoading
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
                    key: _viewModel.formkey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            headerText(
                                texto: 'Crea una cuenta',
                                color: Theme.of(context).primaryColor,
                                fontSize: 30.0),
                            /*userNameInput(),
                        emailInput(),
                        phoneInput(),
                        dateBirthInput(),
                        passwordInput(), */
                            const SizedBox(height: 20.0),
                            CustonTextFormField(
                                textFormFieldType:
                                    CustonTextFormFieldType.username,
                                hintext: "Username",
                                delegate: _viewModel),
                            CustonTextFormField(
                                textFormFieldType:
                                    CustonTextFormFieldType.email,
                                hintext: "Email",
                                delegate: _viewModel),
                            CustonTextFormField(
                                textFormFieldType:
                                    CustonTextFormFieldType.phone,
                                hintext: "Phone",
                                delegate: _viewModel),
                            GestureDetector(
                              onTap: () => _selectDate(context),
                              child: AbsorbPointer(
                                child: CustonTextFormField(
                                    textFormFieldType:
                                        CustonTextFormFieldType.dataOfBirth,
                                    hintext: "Date of birth",
                                    delegate: _viewModel,
                                    controler: _viewModel.dateControler),
                              ),
                            ),
                            CustonTextFormField(
                                textFormFieldType:
                                    CustonTextFormFieldType.password,
                                hintext: "Password",
                                delegate: _viewModel),
                            // buttonSing(context),
                            createButton(
                                context: context,
                                labelButton: "Sing Up",
                                color: orange,
                                func: () {
                                  _ctaTapped(context);
                                }),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 40.0),
                              child: const Text(
                                'Al crear la cuentas estas aceptando los terminos y condiciones',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13.0),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
                ]))
              ],
            ));
  }
}

Widget userNameInput() {
  return Container(
    margin: const EdgeInsets.only(top: 10.0),
    padding: const EdgeInsets.only(left: 20.0),
    decoration: BoxDecoration(
        color: bgInputs, borderRadius: BorderRadius.circular(40.0)),
    child: const TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: 'Nombre de usuario',
          border: OutlineInputBorder(borderSide: BorderSide.none)),
    ),
  );
}

Widget emailInput() {
  return Container(
    margin: const EdgeInsets.only(top: 10.0),
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

Widget phoneInput() {
  return Container(
    margin: const EdgeInsets.only(top: 10.0),
    padding: const EdgeInsets.only(left: 20.0),
    decoration: BoxDecoration(
        color: const Color.fromRGBO(142, 142, 147, 1.2),
        borderRadius: BorderRadius.circular(30.0)),
    child: const TextField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          hintText: 'Celular',
          border: OutlineInputBorder(borderSide: BorderSide.none)),
    ),
  );
}

Widget dateBirthInput() {
  return Container(
    margin: const EdgeInsets.only(top: 10.0),
    padding: const EdgeInsets.only(left: 20.0),
    decoration: BoxDecoration(
        color: const Color.fromRGBO(142, 142, 147, 1.2),
        borderRadius: BorderRadius.circular(30.0)),
    child: const TextField(
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
          hintText: 'Fecha de nacimiento',
          border: OutlineInputBorder(borderSide: BorderSide.none)),
    ),
  );
}

Widget passwordInput() {
  return Container(
    margin: const EdgeInsets.only(top: 10.0),
    padding: const EdgeInsets.only(left: 20.0),
    decoration: BoxDecoration(
        color: const Color.fromRGBO(142, 142, 147, 1.2),
        borderRadius: BorderRadius.circular(30.0)),
    child: const TextField(
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          hintText: 'Contraseña',
          border: OutlineInputBorder(borderSide: BorderSide.none)),
    ),
  );
}

Widget buttonSing(BuildContext context) {
  return Container(
    width: 350.0,
    height: 45.0,
    margin: const EdgeInsets.only(top: 30.0),
    child: ElevatedButton(
        onPressed: () {
          SingUpPage signUpPage = SingUpPage();
          signUpPage._ctaTapped(context);
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
        child: const Text('Crear cuenta',
            style: TextStyle(color: Colors.white, fontSize: 17.0))),
  );
}

extension UserAction on SingUpPage {
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime(1960, 1),
        lastDate: DateTime(2100),
        locale: const Locale("es", ""));

    if (picked != null && picked != _viewModel.selectedDate) {
      _viewModel.singUpModel?.date =
          "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
      _viewModel.dateControler.text =
          "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
    }
  }

  void _ctaTapped(BuildContext context) {
    if (_viewModel.isFormValidate()) {
      _viewModel.singUp().then((result) {
        switch (result.status) {
          case ResultStatus.success:
            Navigator.pushNamed(context, "tabs");
          case ResultStatus.error:
            errorStateProvider.setFailure(
                context: context, value: result.error!);
        }
      });
    }
  }
}
