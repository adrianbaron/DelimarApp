import 'package:app_delivery/src/features/presentacion/widgets/TextFormField/CustonTextFormField.dart';
import 'package:app_delivery/src/utils/extensions/screem_size.dart';
import 'package:app_delivery/src/utils/styles/box_decoration_shadow.dart';
import 'package:flutter/material.dart';

mixin EmailTextFieldCardViewDelegate {
  emailChanged({required String email});
}

class EmailTextFieldCardView extends StatelessWidget
    with TextFormFieldDelegate {
  Decoration? decoration;
  final EmailTextFieldCardViewDelegate? delegate;

  String title = "";
  String? initialValue;

  EmailTextFieldCardView(
      {Key? key,
      required this.delegate,
      required this.title,
      this.decoration,
      this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getBoxDecorationWithShadow(),
      width: getScreenWidth(context: context),
      margin: const EdgeInsets.only(left: 16, right: 16),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Text(title,
              style: const TextStyle(fontSize: 15, color: Colors.orange)),
          const SizedBox(height: 8),
          CustomTextFormField(
            delegate: this,
            hintext: 'Email',
            textFormFieldType: CustomTextFormFieldType.email,
            decoration: decoration ?? defaultTextFieldDecoration,
            initialValue: initialValue,
          ),
          const SizedBox(height: 8)
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
      default:
        break;
    }
  }
}
