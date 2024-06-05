import 'package:app_delivery/src/Base/Constants/ErrorMessage.dart';
import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/presentacion/Profile/EditEmailPage/ViewModel/edit_page_view_model.dart';
import 'package:app_delivery/src/features/presentacion/Profile/EditEmailPage/components/EmailAndPasswordTextFieldCardView.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/ErrorStateProvider.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/LoadingStatusStateProvider.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/user_state_provider.dart';
import 'package:app_delivery/src/features/presentacion/widgets/AppBar/appbar_done_view.dart';
import 'package:app_delivery/src/utils/helpers/Validators/form_validator.dart';
import 'package:app_delivery/src/utils/styles/box_decoration_shadow.dart';
import 'package:flutter/material.dart';

class EditEmailPage extends StatefulWidget {
  const EditEmailPage({super.key});

  @override
  State<EditEmailPage> createState() => _EditEmailPageState();
}

class _EditEmailPageState extends State<EditEmailPage>
    with BaseView, EmailAndPasswordTextFieldCardViewDelegate {
  //Private properties

  String _actionText = "";
  String? _email;
  String? _oldEmail;
  String? _password;
  String? _localId;
  Decoration? _decoration;

  //Dependencia
  final EditEmailPageViewModel _viewModel;

  _EditEmailPageState({EditEmailPageViewModel? editEmailPageViewModel})
      : _viewModel = editEmailPageViewModel ?? DefaultEditEmailPageViewModel();
  @override
  Widget build(BuildContext context) {
    _setOldValues();

    return Scaffold(
        appBar: createAppBarDone(
            title: "Editar email",
            actionText: _actionText,
            onTap: () {
              sendEditEmail(context);
            }),
        body: (context).isLoading()
            ? loadingView
            : CustomScrollView(
                slivers: [
                  SliverList(
                      delegate: SliverChildListDelegate([
                    const SizedBox(height: 16),
                    EmailAndPasswordTextFieldCardView(
                        delegate: this,
                        decoration: _decoration,
                        title:
                            "Porfavor ingresar email y password, despues podra ingresar con sus nuevo datos")
                  ]))
                ],
              ));
  }

  sendEditEmail(BuildContext context) {
    if (_email == null ||
        _oldEmail == null ||
        _password == null ||
        _localId == null) {
      return;
    }

    setState(() {
      (context).setLoadingState(isLoading: true);
    });
    _viewModel.updateEmail(email: _email ?? "",
                           password: _password ?? "",
                           localId: _localId ?? "",
                           oldEmail: _oldEmail ?? "").then((value) {
      setState(() {
        (context).setLoadingState(isLoading: false);
      });
      //Puede tener la opcion de salirse al login
      Navigator.pop(context);
    }, onError: (e) {
      setState(() {
        (context).setLoadingState(isLoading: false);
        context.showErrorAlert(message: AppFailureMessages.unExpectedErrorMessage, context: context);
      });
    });
  }

  @override
  emailChanged({required String email}) {
    _email = email;
    _validateForm();
  }

  @override
  passwordChanged({required String password}) {
    _password = password;
    _validateForm();
  }

  _setOldValues() {
    _localId = (context).getUserData()?.localId;
    _oldEmail = (context).getUserData()?.email;
  }

  _validateForm() {
    if (_email == null || _password == null) {
      return;
    }
    setState(() {
      if (_email!.isEmpty ||
          _password!.isEmpty ||
          EmailFormValidator.validateEmail(email: _email ?? "") != null) {
        //NO ES UN FORM VALIDO
        _email = null;
        _actionText = "";
        _decoration = errorTextFieldDecoration;
      } else {
        _actionText = "Guardar";
        _decoration = null;
      }
    });
  }
}
