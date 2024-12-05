import 'dart:math';

import 'package:app_delivery/src/features/presentacion/SingUpPage/View/sing_up_page.dart';
import 'package:app_delivery/src/features/presentacion/tabs/TabsPage/View/tabs_page.dart';
import 'package:app_delivery/src/features/presentacion/tabs/explorerTab/view/ExploreTab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app_delivery/main.dart' as app;
import 'package:app_delivery/src/features/presentacion/welcomePage/View/welcome_page.dart';
import 'package:app_delivery/src/features/presentacion/loginPage/View/login_page.dart';


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login flow test', () {
    testWidgets('Flujo para Inicir sesion', (WidgetTester tester) async {
      // Iniciar la aplicación
      await tester.runAsync(() async {
        app.main();
      });
      
      // Esperar a que la aplicación se estabilice
      await tester.pump();
      //await Future.delayed(const Duration(seconds: 10));
      await tester.pump();

      // Test 1: Verificar WelcomePage
      expect(find.byType(WelcomePage), findsOneWidget);

  
     // Dar tiempo para que las animaciones se completen
      // Esperar a que la aplicación se estabilice
      await tester.pump();
      await Future.delayed(const Duration(seconds: 10));
      await tester.pump();
      
      
      // Navegar a LoginPage
      await tester.tap(find.text('Iniciar sesion'));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      
    //Verificar Login page
      expect(find.byType(LoginPage), findsOneWidget);
      
       // Esperar antes de la siguiente acción
      await tester.pump(const Duration(milliseconds: 500));
      
      // Navegar llenar el formulario
      final emailField = find.widgetWithText(TextFormField, 'Email');
      final passwordField = find.widgetWithText(TextFormField, 'Password');
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      // ingresar email
      await tester.enterText(emailField, 'aloha@gmail.com');
      await tester.pumpAndSettle();

      // Ingresar contraseña
      await tester.enterText(passwordField, '123456');
      await tester.pumpAndSettle();

      
      // Inciar sesion 
      await tester.tap(find.text('Log in'));
      await tester.pumpAndSettle();

  // Verificar que se haya navegado a la siguiente pantalla 
     expect (find.byType(TabsPage), findsOneWidget);

  
    });
  });
}