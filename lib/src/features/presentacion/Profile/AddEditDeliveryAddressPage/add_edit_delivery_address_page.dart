import 'package:app_delivery/src/Base/Constants/ErrorMessage.dart';
import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/Entidades/DeliveryAddress/delivery_address_entity.dart';
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

class AddEditDeliveryAddressPage extends StatefulWidget {
  DeliveryAddressEntity? deliveryAddressEntity;
  final bool? isEditing;
  BaseViewStateDelegate? viewStateDelegate;

  AddEditDeliveryAddressPage(
      {Key? key,
      required this.isEditing,
      required this.viewStateDelegate,
      required this.deliveryAddressEntity})
      : super(key: key);

  @override
  State<AddEditDeliveryAddressPage> createState() =>
      _AddEditDeliveryAddressPageState();
}

class _AddEditDeliveryAddressPageState extends State<AddEditDeliveryAddressPage>
    with TextFormFieldDelegate, BaseView {
  String _actionText = "";
  Decoration? _streetAndNumberDecoration = defaultTextFieldDecoration;
  Decoration? _floorAndDoorDecoration = defaultTextFieldDecoration;
  Decoration? _cityDecoration = defaultTextFieldDecoration;
  Decoration? _cpDecoration = defaultTextFieldDecoration;
  Decoration? _aliasDecoration = defaultTextFieldDecoration;

  @override
  Widget build(BuildContext context) {
    // Si vamos a crear una nueva dirección tenemos que prepara la view
    _prepareView();

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FABRoundedRectangleView(
          text: 'Delete Delivery Address',
          backgroundColor: Colors.red,
          onPressed: () {
            _showAlertDeleteDeliveryAddress(context);
          },
          isHidden: !_isEditing()),
      appBar: createAppBarDone(
          title:
              _isEditing() ? "Edit Delivery Address" : "Add Delivery Address",
          actionText: _actionText,
          onTap: () {
            _editAddDeliveryAddress(context);
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
                  const Text("STREET AND NUMBER",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.orange,
                          fontWeight: FontWeight.w600)),
                  CustomTextFormField(
                      delegate: this,
                      hintext: 'Ej: 5th Avenue, 156',
                      textFormFieldType: CustomTextFormFieldType.street,
                      decoration: _streetAndNumberDecoration,
                      initialValue: widget.deliveryAddressEntity?.street),
                  const SizedBox(height: 16),
                  const Text("FLOOR AND DOOR",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.orange,
                          fontWeight: FontWeight.w600)),
                  CustomTextFormField(
                      delegate: this,
                      hintext: 'Ej: 6A',
                      textFormFieldType: CustomTextFormFieldType.floor,
                      decoration: _floorAndDoorDecoration,
                      initialValue: widget.deliveryAddressEntity?.floorAndDoor),
                  const SizedBox(height: 16),
                  const Text("CITY",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.orange,
                          fontWeight: FontWeight.w600)),
                  CustomTextFormField(
                      delegate: this,
                      hintext: 'Ej: Madrid',
                      textFormFieldType: CustomTextFormFieldType.city,
                      decoration: _cityDecoration,
                      initialValue: widget.deliveryAddressEntity?.city),
                  const SizedBox(height: 16),
                  const Text("CP",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.orange,
                          fontWeight: FontWeight.w600)),
                  CustomTextFormField(
                      delegate: this,
                      hintext: 'Ej: 16789',
                      textFormFieldType: CustomTextFormFieldType.cp,
                      decoration: _cpDecoration,
                      initialValue: widget.deliveryAddressEntity?.cp),
                  const SizedBox(height: 16),
                  const Text("Notes",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.orange,
                          fontWeight: FontWeight.w600)),
                  CustomTextFormField(
                      delegate: this,
                      hintext: 'Ej: The doorbell does not work',
                      textFormFieldType: CustomTextFormFieldType.notes,
                      decoration: defaultTextFieldDecoration,
                      initialValue: widget.deliveryAddressEntity?.notes),
                  const SizedBox(height: 16),
                  const Text("ADDRESS ALIAS",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.orange,
                          fontWeight: FontWeight.w600)),
                  CustomTextFormField(
                      delegate: this,
                      hintext: 'Ej: Home Address',
                      textFormFieldType: CustomTextFormFieldType.alias,
                      decoration: _aliasDecoration,
                      initialValue: widget.deliveryAddressEntity?.alias),
                  const SizedBox(height: 16)
                ],
              ),
            ),
            const SizedBox(height: 140)
          ]))
        ],
      ),
    );
  }

  @override
  onChanged(
      {required String newValue,
      required CustomTextFormFieldType customTextFormFieldType}) {
    setState(() {
      switch (customTextFormFieldType) {
        case CustomTextFormFieldType.street:
          widget.deliveryAddressEntity?.street = newValue;
          break;
        case CustomTextFormFieldType.floor:
          widget.deliveryAddressEntity?.floorAndDoor = newValue;
          break;
        case CustomTextFormFieldType.city:
          widget.deliveryAddressEntity?.city = newValue;
          break;
        case CustomTextFormFieldType.cp:
          widget.deliveryAddressEntity?.cp = newValue;
          break;
        case CustomTextFormFieldType.notes:
          widget.deliveryAddressEntity?.notes = newValue;
          break;
        case CustomTextFormFieldType.alias:
          widget.deliveryAddressEntity?.alias = newValue;
          break;
        default:
          break;
      }
      _validateForm();
    });
  }
}

extension PrivateMethods on _AddEditDeliveryAddressPageState {
  _validateForm() {
    // TODO: Hacer FE con Google Maps para geolocation
    widget.deliveryAddressEntity?.lat = 41.3914113;
    widget.deliveryAddressEntity?.long = 2.194717;

    if (!_isValidDeliveryAddress()) {
      _actionText = "";
    } else {
      _actionText = "Save";
    }
    _setTextFieldsDecorations();
  }

  _setTextFieldsDecorations() {
    if (widget.deliveryAddressEntity?.street.isEmpty ?? true) {
      _streetAndNumberDecoration = errorTextFieldDecoration;
    } else {
      _streetAndNumberDecoration = defaultTextFieldDecoration;
    }
    if (widget.deliveryAddressEntity?.floorAndDoor.isEmpty ?? true) {
      _floorAndDoorDecoration = errorTextFieldDecoration;
    } else {
      _floorAndDoorDecoration = defaultTextFieldDecoration;
    }
    if (widget.deliveryAddressEntity?.city.isEmpty ?? true) {
      _cityDecoration = errorTextFieldDecoration;
    } else {
      _cityDecoration = defaultTextFieldDecoration;
    }
    if (widget.deliveryAddressEntity?.cp.isEmpty ?? true) {
      _cpDecoration = errorTextFieldDecoration;
    } else {
      _cpDecoration = defaultTextFieldDecoration;
    }
    if (widget.deliveryAddressEntity?.alias.isEmpty ?? true) {
      _aliasDecoration = errorTextFieldDecoration;
    } else {
      _aliasDecoration = defaultTextFieldDecoration;
    }
  }

  bool _isEditing() {
    return widget.isEditing ?? false;
  }

  bool _isValidDeliveryAddress() {
    return widget.deliveryAddressEntity?.isValidDeliveryAddress() ?? false;
  }

  _prepareView() {
    viewStateDelegate = widget.viewStateDelegate;
    if (!_isEditing() && widget.deliveryAddressEntity == null) {
      widget.deliveryAddressEntity =
          DeliveryAddressEntity.getEmptyDeliveryAddress();
    }
  }

  _pop(BuildContext context) {
    viewStateDelegate?.onChange();
    Navigator.pop(context);
  }
}

extension UserActions on _AddEditDeliveryAddressPageState {
  _editAddDeliveryAddress(BuildContext context) {
    setState(() {
      (context).setLoadingState(isLoading: true);
    });

    if (widget.isEditing ?? false) {
      // Aquí editamos la dirección de entrega
      _editDeliveryAddress();
    } else {
      // Aquí creamos la dirección de entrega
      _addDeliveryAddress();
    }
  }

  _editDeliveryAddress() {
    // Null Check
    if (widget.deliveryAddressEntity == null) {
      return;
    }

    (context)
        .editDeliveryAddress(
            deliveryAddressEntity: widget.deliveryAddressEntity!)
        .then((_) {
      setState(() {
        (context).setLoadingState(isLoading: false);
      });
      _pop(context);
    }, onError: (_) {
      (context).showErrorAlert(
          message: AppFailureMessages.unExpectedErrorMessage, context: context);
    });
  }

  _addDeliveryAddress() {
    // Null Check
    if (widget.deliveryAddressEntity == null) {
      return;
    }

    widget.deliveryAddressEntity?.id = CheckoutHelper.generateUuid();
    (context)
        .addDeliveryAddress(
            deliveryAddressEntity: widget.deliveryAddressEntity!)
        .then((_) {
      setState(() {
        (context).setLoadingState(isLoading: false);
      });
      _pop(context);
    }, onError: (_) {
      (context).showErrorAlert(
          message: AppFailureMessages.unExpectedErrorMessage, context: context);
    });
  }

  _showAlertDeleteDeliveryAddress(BuildContext context) {
    AlertView.showAlertDialog(
        model: AlertViewModel(
            context,
            const AssetImage("assets/cancelar.png"),
            "",
            "Estas seguro que quieres eliminar esta direccion?",
            "Delete",
            "Cancel", () {
      // CTA ACTION
      _deleteDeliveryAddress();
    }, () {
      // CANCEL ACTION
      AlertView.closeAlertDialog(context);
    }));
  }

  _deleteDeliveryAddress() {
    // Null Check
    if (widget.deliveryAddressEntity == null) {
      return;
    }
    setState(() {
      (context).setLoadingState(isLoading: true);
    });
    (context)
        .deleteDeliveryAddress(
            deliveryAddressEntity: widget.deliveryAddressEntity!)
        .then((_) {
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
