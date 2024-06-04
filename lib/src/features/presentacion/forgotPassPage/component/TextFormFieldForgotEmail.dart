import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/presentacion/forgotPassPage/ViewModel/forgot_password_view_model.dart';
import 'package:app_delivery/src/utils/helpers/Validators/form_validator.dart';
import 'package:flutter/material.dart';

class TextFormFieldEmailUpdatePassword extends StatelessWidget {
  final ForgotPasswordViewModel viewModel;

  const TextFormFieldEmailUpdatePassword({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: bgInputs, borderRadius: BorderRadius.circular(40.0)),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
            hintText: "Email",
            border: OutlineInputBorder(borderSide: BorderSide.none)),
        validator: (value) =>
            EmailFromValidator.validateEmail(email: value ?? ""),
            onChanged: (NewValue) => viewModel.email = NewValue,
      ),
    );
  }
}
