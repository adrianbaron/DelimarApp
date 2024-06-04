import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/presentacion/tabs/profileTab/model/ProdileTabViewModel.dart';
import 'package:app_delivery/src/features/presentacion/welcomePage/View/welcome_page.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Alertas/alert_dialog.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Botons/create_button.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/header_text.dart';
import 'package:flutter/material.dart';

class ProfileTabContentView extends StatelessWidget {
  final ProfileTabViewModel viewModel;
  const ProfileTabContentView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            leading: const Image(
              image: AssetImage('assets/settingicon.png'),
              width: 29,
              height: 29,
            ),
            title: headerText(
                texto: "Mi informacion",
                fontWeight: FontWeight.w400,
                fontSize: 16),
            trailing: Icon(
              Icons.chevron_right,
              color: gris,
            ),
            onTap: () => Navigator.pushNamed(context, "profile-detail"),
          ),
          const Divider(),
          const SizedBox(height: 16),
          ////
          ListTile(
              leading: const Image(
                image: AssetImage('assets/corona.png'),
                width: 29,
                height: 29,
              ),
              title: Text(
                "Delivery prime",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
              trailing: Icon(Icons.chevron_right, color: gris)),
          ListTile(
              leading: const Image(
                image: AssetImage('assets/promoicon.png'),
                width: 29,
                height: 29,
              ),
              title: Text(
                "Promo Code",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
              trailing: Icon(Icons.chevron_right, color: gris)),
          ListTile(
              leading: const Image(
                image: AssetImage('assets/inviteicon.png'),
                width: 29,
                height: 29,
              ),
              title: Text(
                "Invitar un amigo",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
              trailing: Icon(Icons.chevron_right, color: gris)),
          const Divider(),
          const SizedBox(height: 16),
          ListTile(
              leading: const Image(
                image: AssetImage('assets/noti.png'),
                width: 29,
                height: 29,
              ),
              title: Text(
                "Notificaciones",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
              trailing: Icon(Icons.chevron_right, color: gris)),
          ListTile(
              leading: const Image(
                image: AssetImage('assets/cancelar.png'),
                width: 29,
                height: 29,
              ),
              title: Text(
                "Eliminar cuenta",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
              trailing: Icon(Icons.chevron_right, color: gris)),

          //////////////////
          ListTile(
            leading: const Image(
              image: AssetImage('assets/switch.png'),
              width: 29,
              height: 29,
            ),
            title: const Text("Cerrar Sesion",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
            trailing: Icon(
              Icons.chevron_right,
              color: gris,
            ),
            onTap: () => _singOut(context),
          ),
        ],
      ),
    );
  }

  Future _singOut(BuildContext context) async {
    await showAlertDialog(
        context,
        const AssetImage("assets/switch.png"),
        "Cerrar sesion",
        "Desea salir de la sesion",
        createButton(
            context: context,
            labelButton: "Salir",
            color: orange,
            func: () {
              viewModel.singOut().then((_) {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => WelcomePage(),
                        transitionDuration: const Duration(seconds: 0)));
              });
            }));
  }
}
