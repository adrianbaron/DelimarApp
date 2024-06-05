import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/presentacion/Profile/EditPasswordPage/components/email_text_field_card_view.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/LoadingStatusStateProvider.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/user_state_provider.dart';
import 'package:app_delivery/src/features/presentacion/forgotPassPage/ViewModel/forgot_password_view_model.dart';
import 'package:app_delivery/src/features/presentacion/widgets/AppBar/appbar_done_view.dart';
import 'package:app_delivery/src/utils/helpers/Validators/form_validator.dart';
import 'package:flutter/material.dart';

class EditPasswordPage extends StatefulWidget {
  const EditPasswordPage({Key? key}) : super(key: key);

  @override
  State<EditPasswordPage> createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage>
    with EmailTextFieldCardViewDelegate, BaseView {
  String _actionText = "";
  String? _email;

  // Dependencies
  final ForgotPasswordViewModel _viewModel;

  _EditPasswordPageState({ForgotPasswordViewModel? viewModel})
      : _viewModel = viewModel ?? DefaultForgotPasswordViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBarDone(
          actionText: _actionText,
          onTap: _sendEditPasswordEmail,
          title: 'Edit Password'),
      body: (context).isLoading()
          ? loadingView
          : CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildListDelegate([
                  const SizedBox(height: 16),
                  EmailTextFieldCardView(
                      delegate: this,
                      title:
                          "Please enter your email address. You will receive a link to create a new password via email.",
                      initialValue: (context).getUserData()?.email)
                ]))
              ],
            ),
    );
  }

  _sendEditPasswordEmail() {
    if (_email == null) {
      return;
    }
    setState(() {
      (context).setLoadingState(isLoading: true);
    });
    _viewModel.updatePassword(email: _email ?? "").then((_) {
      setState(() {
        (context).setLoadingState(isLoading: false);
      });
      Navigator.pop(context);
    });
  }

  @override
  emailChanged({required String email}) {
    setState(() {
      if (email.isEmpty ||
          EmailFormValidator.validateEmail(email: email) != null) {
        _email = null;
        _actionText = "";
      } else {
        _email = email;
        _actionText = "Guadar";
      }
    });
  }
}
