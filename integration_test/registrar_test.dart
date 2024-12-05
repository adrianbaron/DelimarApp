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

  group('User Registration Flow Test', () {
    testWidgets('Flujo para registrar usuario', (WidgetTester tester) async {
      // Iniciar la aplicación
      await tester.runAsync(() async {
        app.main();
      });
      
      // Esperar a que la aplicación se estabilice
      await tester.pump();
      await Future.delayed(const Duration(seconds: 10));
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
      
      // Navegar a SignUpPage
      await tester.tap(find.text('Crea una cuenta'));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      // Test 3: Verificar SignUpPage
      expect(find.byType(SignUpPage), findsOneWidget);

       // Llenar formulario con delays entre campos
      // Encontrar campos y botón de "Sign up"
      final usernameField = find.widgetWithText(TextFormField, 'Username');
      final emailField = find.widgetWithText(TextFormField, 'Email');
      final phoneField = find.widgetWithText(TextFormField, 'Phone');
      final dateOfBirthField = find.widgetWithText(TextFormField, 'Date of Birth');
      final passwordField = find.widgetWithText(TextFormField, 'Password');
      final signUpButton = find.widgetWithText(ElevatedButton, 'Sign up');

      // Interactuar con los campos
      await tester.enterText(usernameField, 'JohnDoe');
      await tester.pumpAndSettle();
      await tester.enterText(emailField, 'jdrxt@gmail.com');
      await tester.pumpAndSettle();
      await tester.enterText(phoneField, '3107233222');
      await tester.pumpAndSettle();
      // Simular la selección de fecha
      await tester.tap(dateOfBirthField);
      await tester.pumpAndSettle();
     // Confirmar la selección de la fecha
      final confirmButton = find.text('ACEPTAR');
      await tester.tap(confirmButton);
      await tester.pumpAndSettle();


  // Ingresar contraseña
      await tester.enterText(passwordField, '123456');
      await tester.pumpAndSettle();

  // Registrar usuario
      await tester.tap(find.text('Sign up'));
      await tester.pumpAndSettle(const Duration(seconds: 1));
     
 // Esperar a que la aplicación se estabilice
      await tester.pump();
      await Future.delayed(const Duration(seconds: 4));
      await tester.pump();
      
  expect (find.byType(TabsPage), findsOneWidget);

      
    });
  });
}