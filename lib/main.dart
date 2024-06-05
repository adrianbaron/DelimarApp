import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/presentacion/MainCordinator/MainCordinator.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/ErrorStateProvider.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/LoadingStatusStateProvider.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/user_state_provider.dart';
import 'package:app_delivery/src/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ErrorStateProvider()),
        ChangeNotifierProvider(create: (_) => LoadingStateProvider()),
        ChangeNotifierProvider(create: (_) => DefaultUserStateProvider())
      ],
      child: MyAppUserState(),
    );
  }
}

class MyAppUserState extends StatelessWidget with BaseView {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MainCoordinator.sharedInstance
            ?.star(), // Aquí se llama al método start()
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Provider.of<DefaultUserStateProvider>(context).fetchUserData(
                localId: MainCoordinator.sharedInstance?.userUid ?? "");
            print("por aca llegue");
            return MyApp(initialRoute: snapshot.data);
          } else {
            // Mientras se carga
            return CircularProgressIndicator();
          }
        });
  }
}

class MyApp extends StatelessWidget {
  final String _initialRoute;
  MyApp({required String initialRoute}) : _initialRoute = initialRoute;

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: _initialRoute,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: orange,
          appBarTheme:
              const AppBarTheme(iconTheme: IconThemeData(color: Colors.black))),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('es', ''), // Spanish, no country code
      ],
    );
  }
}
