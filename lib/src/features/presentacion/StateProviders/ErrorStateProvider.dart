import 'package:app_delivery/src/Base/APIservice/AppError.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Alertas/error_alert_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

mixin ErrorStateProviderDelegate {
  void setFailure({required BuildContext context, required Failure value});
}

class ErrorStateProvider extends ChangeNotifier
    with ErrorStateProviderDelegate {
  late Failure _Failure;
  @override
  void setFailure({required BuildContext context, required Failure value}) {
    _Failure = value;
    _showAlert(context: context, message: _Failure.toString());
    notifyListeners();
  }

  void _showAlert({required BuildContext context, required String message}) {
    ErrorAlertView.showErrorAlertDialog(
        context: context,
        subtitle: message,
        ctaButtonAction: () {
          Navigator.pop(context);
        });
  }
}

extension ErrorStateProviderExtension on BuildContext {
  showErrorAlert({required BuildContext context, required String message}) =>
      Provider.of<ErrorStateProvider>(this, listen: false)
          ._showAlert(context: context, message: message);
}
