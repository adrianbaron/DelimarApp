import 'package:app_delivery/src/Base/Constants/ErrorMessage.dart';
import 'package:app_delivery/src/Base/Views/BaseView.dart';

import 'package:app_delivery/src/features/logica/Entidades/User/UserEntity.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/ErrorStateProvider.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/LoadingStatusStateProvider.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/user_state_provider.dart';
import 'package:app_delivery/src/features/presentacion/Profile/profile_detail_page/view/components/avatar_profile_view.dart';
import 'package:app_delivery/src/features/presentacion/widgets/BackBoton/back_button.dart';

import 'package:app_delivery/src/features/presentacion/widgets/Headers/text_view.dart';
import 'package:app_delivery/src/utils/extensions/screem_size.dart';
import 'package:app_delivery/src/utils/helpers/UserPhoto/userPhotoHelpers.dart';
import 'package:app_delivery/src/utils/styles/box_decoration_shadow.dart';
import 'package:flutter/material.dart';

import 'components/field_profile_view.dart';

class ProfileDetailPage extends StatefulWidget {
  const ProfileDetailPage({Key? key}) : super(key: key);

  @override
  _ProfileDetailPageState createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage>
    with TextFieldProfileDetailViewDelegate, BaseView {
  String _actionText = "";
  late DefaultUserStateProvider _defaultUserStateProvider;
  UserEntity? newUser;

  @override
  Widget build(BuildContext context) {
    _defaultUserStateProvider = (context).getDefaultUserStateProvider();

    return Scaffold(
      appBar: _appBar(text: _actionText),
      body: (context).isLoading()
          ? loadingView
          : CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildListDelegate([
                  Container(
                      margin: EdgeInsets.only(
                          top: getScreenHeight(
                              context: context, multiplier: 0.05),
                          left: 15,
                          right: 15),
                      padding: const EdgeInsets.only(bottom: 32),
                      decoration: getBoxDecorationWithShadows(),
                      width: getScreenWidth(context: context),
                      child: Column(
                        children: [
                          Transform.translate(
                              offset: Offset(
                                  0,
                                  -getScreenHeight(
                                      context: context, multiplier: 0.03)),
                              child: AvatarProfileView(
                                  backgroundimage: _defaultUserStateProvider
                                          .userData?.photo ??
                                      UserPhotoHelper.defaultUserPhoto)),
                          TextFieldsProfileDetailView(
                              userData: _defaultUserStateProvider.userData,
                              delegate: this)
                        ],
                      )),
                  SizedBox(
                      height:
                          getScreenHeight(context: context, multiplier: 0.1))
                ]))
              ],
            ),
    );
  }

  PreferredSizeWidget? _appBar({required String text}) {
    return AppBar(
      title: const TextView(texto: 'Mi informacion', fontSize: 17),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0.4,
      leading: Builder(
        builder: (BuildContext context) {
          return const BackButtonView(color: Colors.black);
        },
      ),
      actions: [
        GestureDetector(
          onTap: () {
            updateUserData();
          },
          child: Container(
              padding: const EdgeInsets.only(top: 20, right: 15.0),
              child: Text(text,
                  style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500))),
        )
      ],
    );
  }

  updateUserData() {
    if (newUser == null) {
      return;
    }
    setState(() {
      (context).setLoadingState(isLoading: true);
    });
    _defaultUserStateProvider.updateUserData(user: newUser!).then((result) {
      setState(() {
        (context).setLoadingState(isLoading: false);
        _actionText = "";
      });
    }, onError: (e) {
      setState(() {
        (context).setLoadingState(isLoading: false);
        (context).showErrorAlert(
            context: context,
            message: AppFailureMessages.unExpectedErrorMessage);
      });
    });
  }

  @override
  userDataChanged({required UserEntity? newUser}) {
    this.newUser = newUser;
    setState(() {
      _actionText = "Guardar";
    });
  }
}
