import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/utils/helpers/Validators/form_validator.dart';
import 'package:flutter/material.dart';

mixin TextFormFieldDelegate {
  onChange(
      {required String newValue,
      required CustonTextFormFieldType custonTextFormFieldType});
}

enum CustonTextFormFieldType { email, password, phone, username, dataOfBirth }

class CustonTextFormField extends StatelessWidget {
  final CustonTextFormFieldType textFormFieldType;
  final String hintext;
  final TextFormFieldDelegate delegate;
  final TextEditingController? _controler;
  final Decoration? _decoration;
  final String? _initialValue;
  final Widget? _icon;
  CustonTextFormField(
      {super.key,
      required this.textFormFieldType,
      required this.hintext,
      required this.delegate,
      TextEditingController? controler,
      Decoration? decoration,
      String? initialValue,
      Widget? icon
      
      })
      : _controler = controler, _decoration = decoration,_initialValue = initialValue, _icon = icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration:_decoration ?? BoxDecoration(
          color: bgInputs, borderRadius: BorderRadius.circular(40.0)),
      child: TextFormField(
        controller: _controler,
        initialValue: _initialValue,
        keyboardType: getKeyboardType(textFormFieldType: textFormFieldType),
        obscureText: textFormFieldType == CustonTextFormFieldType.password
            ? true
            : false,
        decoration: InputDecoration(
          icon: _icon,
            hintText: hintext,
            border: const OutlineInputBorder(borderSide: BorderSide.none)),
        onChanged: (newValue) => delegate.onChange(
            newValue: newValue, custonTextFormFieldType: textFormFieldType),
        validator: (value) {
          switch (textFormFieldType) {
            case CustonTextFormFieldType.email:
              return EmailFromValidator.validateEmail(email: value ?? "");
            case CustonTextFormFieldType.password:
              return PasswordFormValidator.validatePassword(
                  password: value ?? "");
            case CustonTextFormFieldType.phone:
              return DefaultFormValidator.validateIsNotEmpy(value: value ?? "");
            case CustonTextFormFieldType.username:
              return DefaultFormValidator.validateIsNotEmpy(value: value ?? "");
            case CustonTextFormFieldType.dataOfBirth:
              return DefaultFormValidator.validateIsNotEmpy(value: value ?? "");
          }
        },
      ),
    );
  }

  TextInputType? getKeyboardType(
      {required CustonTextFormFieldType textFormFieldType}) {
    switch (textFormFieldType) {
      case CustonTextFormFieldType.email:
        return TextInputType.emailAddress;
      case CustonTextFormFieldType.password:
        return TextInputType.visiblePassword;
      case CustonTextFormFieldType.phone:
        return TextInputType.phone;
      case CustonTextFormFieldType.username:
        return TextInputType.text;
      case CustonTextFormFieldType.dataOfBirth:
        return TextInputType.datetime;
    }
  }
}
