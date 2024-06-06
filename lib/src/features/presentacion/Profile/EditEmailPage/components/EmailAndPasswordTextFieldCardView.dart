import 'package:app_delivery/src/features/presentacion/widgets/TextFormField/CustonTextFormField.dart';
import 'package:app_delivery/src/utils/extensions/screem_size.dart';
import 'package:app_delivery/src/utils/styles/box_decoration_shadow.dart';
import 'package:flutter/material.dart';

mixin EmailAndPasswordTextFieldCardViewDelegate {
  emailChanged({required String email});
  passwordChanged({required String password});
}

class EmailAndPasswordTextFieldCardView extends StatelessWidget
    with TextFormFieldDelegate {
  Decoration? decoration;
  final EmailAndPasswordTextFieldCardViewDelegate? delegate;
  String title = "";
  EmailAndPasswordTextFieldCardView(
      {Key? key, required this.delegate, required this.title, this.decoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getBoxDecorationWithShadows(),
      width: getScreenWidth(context: context),
      margin: const EdgeInsets.only(left: 16, right: 16),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 15, color: Colors.orange),
          ),
          const SizedBox(height: 8),
          CustomTextFormField(
              textFormFieldType: CustomTextFormFieldType.email,
              hintext: "Nuevo email",
              delegate: this,
              decoration: decoration ?? defaultTextFieldDecoration),
          const SizedBox(height: 8),
          CustomTextFormField(
              textFormFieldType: CustomTextFormFieldType.password,
              hintext: "Password",
              delegate: this,
              decoration: decoration ?? defaultTextFieldDecoration),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  @override
  onChanged(
      {required String newValue,
      required CustomTextFormFieldType customTextFormFieldType}) {
    switch (customTextFormFieldType) {
      case CustomTextFormFieldType.email:
        delegate?.emailChanged(email: newValue);
      case CustomTextFormFieldType.password:
        delegate?.passwordChanged(password: newValue);

      default:
        break;
    }
  }
}
