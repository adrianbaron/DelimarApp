import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/logica/Entidades/User/UserEntity.dart';
import 'package:app_delivery/src/features/presentacion/MainCordinator/MainCordinator.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/user_state_provider.dart';
import 'package:app_delivery/src/features/presentacion/widgets/TextFormField/CustonTextFormField.dart';
import 'package:flutter/material.dart';

mixin TextFieldProfileDetailViewDelegate {
  userDataChanged({required UserEntity? newUser});
}

class TextFieldsProfileDetailView extends StatelessWidget
    with TextFormFieldDelegate, BaseView {
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
          CustomTextFormField(
              textFormFieldType: CustomTextFormFieldType.username,
              hintext: "Nombre de usuario",
              delegate: this,
              decoration: _decoration,
              initialValue: (context).getUserData()?.username,
              icon: Icon(Icons.person_outlined, color: orange)),
          const Divider(),
          CustomTextFormField(
              textFormFieldType: CustomTextFormFieldType.phone,
              hintext: "Celular",
              delegate: this,
              decoration: _decoration,
              initialValue: (context).getUserData()?.phone,
              icon: Icon(Icons.phone_iphone_outlined, color: orange)),
          const Divider(),
          const SizedBox(height: 16),
          /////
          userData?.provider == UserAuthProvider.emailAndPassword
              ? _ChangeEmailView()
              : Container(),
          userData?.provider == UserAuthProvider.emailAndPassword
              ? _ChangePasswordView()
              : Container(),
          ////////
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
            onTap: () {
              coordinator.showChangePaymentsMethodsPage(context: context);
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.delivery_dining_outlined, color: orange),
            title: const Text(
              "Cambiar direccion",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: gris,
            ),
            onTap: () {
              coordinator.showChangeDeliveryAddress(context: context);
            },
          ),
          const Divider()
        ],
      ),
    );
  }

  @override
  onChanged(
      {required String newValue,
      required CustomTextFormFieldType customTextFormFieldType}) {
    switch (customTextFormFieldType) {
      case CustomTextFormFieldType.username:
        userData?.username = newValue;
        delegate.userDataChanged(newUser: userData);
      case CustomTextFormFieldType.phone:
        userData?.phone = newValue;
        delegate.userDataChanged(newUser: userData);
      default:
        break;
    }
  }
}

class _ChangeEmailView extends StatelessWidget with BaseView {
  _ChangeEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.email_outlined, color: orange),
          title: Text(
            "Cambiar correo",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: gris,
          ),
          onTap: () => coordinator.showEditEmailPage(context: context),
        ),
        Divider(),
      ],
    );
  }
}

class _ChangePasswordView extends StatelessWidget with BaseView {
  _ChangePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.lock_outlined, color: orange),
          title: Text(
            "Cambiar constraseña",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: gris,
          ),
          onTap: () => coordinator.showEditPasswordPage(context: context),
        ),
        const Divider(),
      ],
    );
  }
}
