import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/utils/helpers/Validators/form_validator.dart';
import 'package:flutter/material.dart';

mixin TextFormFieldDelegate {
  onChanged({ required String newValue,
              required CustomTextFormFieldType customTextFormFieldType });
}

enum CustomTextFormFieldType {
  email, password, phone, username, dateOfBirth,
  nameInTheCard, cardNumber, monthAndYearInCard, cvc, country
}

class CustomTextFormField extends StatelessWidget {

  final TextFormFieldDelegate delegate;
  final CustomTextFormFieldType textFormFieldType;
  final String hintext;
  final TextEditingController? _controller;
  final Decoration? _decoration;
  final String? _initialValue;
  final Widget? _icon;

  CustomTextFormField({ required this.delegate,
                        required this.textFormFieldType,
                        required this.hintext,
                        TextEditingController? controller,
                        Decoration? decoration,
                        String? initialValue,
                        Widget? icon })
      : _controller = controller,
        _decoration = decoration,
        _initialValue = initialValue,
        _icon = icon;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10.0),
        padding: const EdgeInsets.only(left: 4.0),
        decoration: _decoration ?? BoxDecoration(
            color: bgInputs,
            borderRadius: BorderRadius.circular(40.0)),
        child: TextFormField(
          initialValue: _initialValue,
          controller: _controller,
          keyboardType: getKeyboardType(textFormFieldType: textFormFieldType),
          obscureText: textFormFieldType == CustomTextFormFieldType.password ? true : false,
          decoration: InputDecoration(
              icon: _icon,
              hintText: hintext,
              border: const OutlineInputBorder(borderSide: BorderSide.none)
          ),
          onChanged: (newValue) => delegate.onChanged(newValue: newValue, customTextFormFieldType: textFormFieldType),
          validator: (value) {
                switch (textFormFieldType) {
                  case CustomTextFormFieldType.email:
                    return EmailFormValidator.validateEmail(email: value ?? '');
                  case CustomTextFormFieldType.password:
                    return PasswordFormValidator.validatePassword(password: value ?? '');
                  case CustomTextFormFieldType.username:
                    return DefaultFormValidator.validateIsNotEmpty(value: value ?? '');
                  case CustomTextFormFieldType.phone:
                    return DefaultFormValidator.validateIsNotEmpty(value: value ?? '');
                  default:
                    return null;
                }
          },
        ));
  }

  TextInputType? getKeyboardType({ required CustomTextFormFieldType textFormFieldType }) {
     switch (textFormFieldType) {
       case CustomTextFormFieldType.email:
         return TextInputType.emailAddress;
       case CustomTextFormFieldType.password:
         return TextInputType.visiblePassword;
       case CustomTextFormFieldType.username:
         return TextInputType.text;
       case CustomTextFormFieldType.phone:
         return TextInputType.phone;
       case CustomTextFormFieldType.cardNumber:
         return TextInputType.number;
       case CustomTextFormFieldType.cvc:
         return TextInputType.number;
       default:
         return TextInputType.text;
     }
  }
}