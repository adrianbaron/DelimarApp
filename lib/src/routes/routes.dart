import 'package:app_delivery/src/features/presentacion/Profile/EditEmailPage/edit_email_page.dart';
import 'package:app_delivery/src/features/presentacion/Profile/EditPasswordPage/edit_password_page.dart';
import 'package:app_delivery/src/features/presentacion/SingUpPage/View/sing_up_page.dart';
import 'package:app_delivery/src/features/presentacion/forgotPassPage/View/forgot_passpage.dart';
import 'package:app_delivery/src/features/presentacion/places_detail_page/View/place_detail_page.dart';
import 'package:app_delivery/src/features/presentacion/Profile/profile_detail_page/view/profile_detail_page.dart';
import 'package:app_delivery/src/features/presentacion/tabs/TabsPage/View/tabs_page.dart';
import 'package:app_delivery/src/features/presentacion/welcomePage/View/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:app_delivery/src/features/presentacion/loginPage/View/login_page.dart';

import '../features/presentacion/flutter_page/View/flutter_page.dart';

final routes = <String, WidgetBuilder>{
  'welcome': (BuildContext context) => WelcomePage(),
  'login': (BuildContext context) => LoginPage(),
  'forgot-pass': (BuildContext context) => ForgotPassword(),
  'singUp': (BuildContext context) => SignUpPage(),
  'tabs': (BuildContext context) => TabsPage(),
  //'search': (BuildContext context) => SearchPage(),
  'filter': (BuildContext context) => FilterPage(),
  // 'collections': (BuildContext context) => CollectionPage(),
  //'collectionDetail': (BuildContext context) => CollectionDetailPage(),
  'PlaceDetail': (BuildContext context) => PlaceDetailPage(),
  'profile-detail': (BuildContext context) => ProfileDetailPage(),
  'edit-email': (BuildContext context) => EditEmailPage(),
  'edit-password': (BuildContext context) => EditPasswordPage(),
};
