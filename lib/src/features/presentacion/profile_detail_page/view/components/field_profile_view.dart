import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/logica/Entidades/User/UserEntity.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/user_state_provider.dart';
import 'package:app_delivery/src/features/presentacion/widgets/TextFormField/CustonTextFormField.dart';
import 'package:flutter/material.dart';

mixin TextFieldProfileDetailViewDelegate {
  userDataChanged({required UserEntity? newUser});
}

class TextFieldsProfileDetailView extends StatelessWidget
    with TextFormFieldDelegate {
  Decoration? _decoration;
  final UserEntity? userData;
  final TextFieldProfileDetailViewDelegate delegate;
  TextFieldsProfileDetailView(
      {super.key, required this.delegate, required this.userData});

  @override
  Widget build(BuildContext context) {
    _decoration = const BoxDecoration(border: Border(bottom: BorderSide.none));
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          CustonTextFormField(
              textFormFieldType: CustonTextFormFieldType.username,
              hintext: "Nombre de usuario",
              delegate: this,
              decoration: _decoration,
              initialValue: (context).getUserData()?.username,
              icon: Icon(Icons.person_outlined, color: orange)),
          const Divider(),
          CustonTextFormField(
              textFormFieldType: CustonTextFormFieldType.phone,
              hintext: "Celular",
              delegate: this,
              decoration: _decoration,
              initialValue: (context).getUserData()?.phone,
              icon: Icon(Icons.phone_iphone_outlined, color: orange)),
          const Divider(),
          const SizedBox(height: 16),
          ListTile(
            leading: Icon(Icons.email_outlined, color: orange),
            title: Text(
              "Cambiar correo",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: gris,
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.lock_outlined, color: orange),
            title: Text(
              "Cambiar constraseña",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: gris,
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.credit_card_outlined, color: orange),
            title: Text(
              "Cambiar metodos de pago",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: gris,
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.delivery_dining_outlined, color: orange),
            title: Text(
              "Cambiar direccion",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: gris,
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  @override
  onChange(
      {required String newValue,
      required CustonTextFormFieldType custonTextFormFieldType}) {
    switch (custonTextFormFieldType) {
      case CustonTextFormFieldType.username:
        userData?.username = newValue;
        delegate.userDataChanged(newUser: userData);

      case CustonTextFormFieldType.phone:
        userData?.phone = newValue;
        delegate.userDataChanged(newUser: userData);
      default:
        break;
    }
  }
}
