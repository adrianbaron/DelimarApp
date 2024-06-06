import 'package:app_delivery/src/Base/Constants/ErrorMessage.dart';
import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/Entidades/PaymentsMethods/payments_methods_entity.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/ErrorStateProvider.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/LoadingStatusStateProvider.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/user_state_provider.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Alertas/AlertView/Model/alert_view_model.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Alertas/AlertView/alert_view.dart';
import 'package:app_delivery/src/features/presentacion/widgets/AppBar/appbar_done_view.dart';
import 'package:app_delivery/src/features/presentacion/widgets/FAB/fab_rounded_rectangle_view.dart';
import 'package:app_delivery/src/features/presentacion/widgets/TextFormField/CustonTextFormField.dart';
import 'package:app_delivery/src/utils/extensions/screem_size.dart';
import 'package:app_delivery/src/utils/helpers/CheckoutHelper/check_out_helper.dart';
import 'package:app_delivery/src/utils/styles/box_decoration_shadow.dart';
import 'package:flutter/material.dart';

class AddEditPaypalAccountPage extends StatefulWidget {
  bool? isEditing;
  PaymentMethodEntity? paymentMethod;
  BaseViewStateDelegate? viewStateDelegate;

  AddEditPaypalAccountPage(
      {Key? key, this.isEditing, this.paymentMethod, this.viewStateDelegate})
      : super(key: key);

  @override
  State<AddEditPaypalAccountPage> createState() =>
      _AddEditPaypalAccountPageState();
}

class _AddEditPaypalAccountPageState extends State<AddEditPaypalAccountPage>
    with TextFormFieldDelegate, BaseView {

  String _actionText = "";
  Decoration? _decoration = defaultTextFieldDecoration;

  @override
  Widget build(BuildContext context) {

    // Si vamos a crear un nuevo método de pago, la property payment method no puede ser nula 😉
    _prepareView();

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FABRoundedRectangleView(
          text: 'Delete Paypal Account',
          backgroundColor: Colors.red,
          onPressed: () {
            _showAlertDeleteAccount(context);
          },
          isHidden: !_isEditing()),
      appBar: createAppBarDone(
          title: _isEditing() ? "Edit Paypal Account" : "Add Paypal Account",
          actionText: _actionText,
          onTap: () {
            _addEditPaypalAccount(context);
          }),
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            const SizedBox(height: 16),
            Container(
              decoration: getBoxDecorationWithShadows(),
              width: getScreenWidth(context: context),
              margin: const EdgeInsets.only(left: 16, right: 16),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("PAYPAL EMAIL",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.orange,
                          fontWeight: FontWeight.w600)),
                  CustomTextFormField(
                    delegate: this,
                    hintext: 'Paypal Email',
                    textFormFieldType: CustomTextFormFieldType.email,
                    decoration: _decoration,
                    initialValue: widget.paymentMethod?.email ?? "",
                  ),
                  const SizedBox(height: 16)
                ],
              ),
            )
          ]))
        ],
      ),
    );
  }

  @override
  onChanged({ required String newValue,
              required CustomTextFormFieldType customTextFormFieldType}) {
    setState(() {
      switch (customTextFormFieldType) {
        case CustomTextFormFieldType.email:
          widget.paymentMethod?.email = newValue;
          break;
        default:
          break;
      }
      _validateForm();
    });
  }

  _pop(BuildContext context) {
    viewStateDelegate?.onChange();
    Navigator.pop(context);
  }
}

extension PrivateMethods on _AddEditPaypalAccountPageState {
  _validateForm() {
    if (( widget.paymentMethod?.email.isEmpty ?? true ) ||
          !CheckoutHelper.isValidEmail(email: widget.paymentMethod?.email ?? "")) {
      _actionText = "";
      _decoration = errorTextFieldDecoration;
    } else {
      _actionText = "Save";
      _decoration = defaultTextFieldDecoration;
    }
  }

  _showAlertDeleteAccount(BuildContext context) {
    AlertView.showAlertDialog(model: AlertViewModel(context,
        AssetImage("assets/cancelar.png"),
        "",
        "Are you sure to remove this Payment method?",
        "Delete", "Cancel", () {
          _deletePaypalAccount(context);
        }, () {
          AlertView.closeAlertDialog(context);
        }));
  }

  bool _isEditing() {
    return widget.isEditing ?? false;
  }

  _prepareView() {
    viewStateDelegate = widget.viewStateDelegate;
    if(!_isEditing() && widget.paymentMethod == null) {
      widget.paymentMethod = PaymentMethodEntity.getEmptyPaymentMethod();
    }
  }

  _addEditPaypalAccount(BuildContext context) {
    setState(() {
      (context).setLoadingState(isLoading: true);
    });

    if (_isEditing()) {
      // Aquí editamos la cuenta
      _editPaypalAccount();
    } else {
      // Aquí añadimos la cuenta
      _addPaypalAccount();
    }
  }

  _addPaypalAccount() {
    // Null Check
    if (widget.paymentMethod == null) {
      return;
    }

    widget.paymentMethod?.type = "paypal";
    widget.paymentMethod?.id = CheckoutHelper.generateUuid();

    (context).addPaymentMethod(paymentMethod: widget.paymentMethod!).then((_) {
      setState(() {
        (context).setLoadingState(isLoading: false);
      });
      _pop(context);
    }, onError: (_) {
      (context).showErrorAlert(message: AppFailureMessages.unExpectedErrorMessage,
          context: context);
    });
  }

  _editPaypalAccount() {
    // Null Check
    if (widget.paymentMethod == null) {
      return;
    }

    (context).editPaymentMethod(paymentMethod: widget.paymentMethod!).then((_) {
      setState(() {
        (context).setLoadingState(isLoading: false);
      });
      _pop(context);
    }, onError: (_) {
      (context).showErrorAlert(message: AppFailureMessages.unExpectedErrorMessage, context: context);
    });
  }

  _deletePaypalAccount(BuildContext context) {
    // Null Check
    if (widget.paymentMethod == null) {
      return;
    }
    setState(() {
      (context).setLoadingState(isLoading: true);
    });

    (context).deletePaymentMethod(paymentMethod: widget.paymentMethod!).then(
        (_) {
      setState(() {
        (context).setLoadingState(isLoading: false);
      });
      AlertView.closeAlertDialog(context);
      _pop(context);
    }, onError: (_) {
      setState(() {
        (context).setLoadingState(isLoading: false);
      });
      AlertView.closeAlertDialog(context);
      _pop(context);
    });
  }
}
