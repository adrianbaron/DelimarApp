import 'package:app_delivery/src/Base/Constants/ErrorMessage.dart';
import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/logica/Entidades/DeliveryAddress/delivery_address_entity.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/ErrorStateProvider.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/LoadingStatusStateProvider.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/user_state_provider.dart';
import 'package:app_delivery/src/features/presentacion/widgets/TextFormField/CustonTextFormField.dart';
import 'package:app_delivery/src/utils/styles/box_decoration_shadow.dart';
import 'package:flutter/material.dart';

mixin DeliveryAddressViewDelegate {
  cardTapped(
      {required BuildContext context,
      required DeliveryAddressEntity deliveryAddressEntity});
}

class DeliveryAddressListView extends StatefulWidget {
  DeliveryAddressViewDelegate? delegate;
  DeliveryAddressListEntity? deliveryAddressListEntity;
  BaseViewStateDelegate? viewStateDelegate;

  DeliveryAddressListView(
      {Key? key,
      required this.delegate,
      required this.deliveryAddressListEntity,
      required this.viewStateDelegate})
      : super(key: key);

  @override
  State<DeliveryAddressListView> createState() =>
      _DeliveryAddressListViewState();
}

class _DeliveryAddressListViewState extends State<DeliveryAddressListView>
    with TextFormFieldDelegate {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: getDeliveryAddressWidgetList(context),
    );
  }

  List<Widget> getDeliveryAddressWidgetList(BuildContext context) {
    if (widget.deliveryAddressListEntity == null) {
      return [];
    }

    return widget.deliveryAddressListEntity?.deliveryAddressList
            .map((deliveryAddressEntity) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  widget.delegate?.cardTapped(
                      context: context,
                      deliveryAddressEntity: deliveryAddressEntity);
                },
                child: CustomTextFormField(
                  delegate: this,
                  hintext: '',
                  textFormFieldType: CustomTextFormFieldType.email,
                  decoration: deliveryAddressEntity.isMainDeliveryAddress
                      ? defaultTextFieldDecoration
                      : borderGrayDecoration,
                  labelValue: deliveryAddressEntity.alias.toUpperCase(),
                  initialValue: deliveryAddressEntity.street,
                  enabled: false,
                ),
              ),
              deliveryAddressEntity.isMainDeliveryAddress
                  ? Container()
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.deliveryAddressListEntity
                              ?.updateMainDeliveryAddress(
                                  id: deliveryAddressEntity.id);
                          _editMainDeliveryAddress();
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 6),
                        child: Text("Marcar como primaria",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: rosa)),
                      ),
                    )
            ],
          );
        }).toList() ??
        [];
  }

  @override
  onChanged(
      {required String newValue,
      required CustomTextFormFieldType customTextFormFieldType}) {}

  _editMainDeliveryAddress() {
    if (widget.deliveryAddressListEntity == null) {
      return;
    }
    setState(() {
      (context).setLoadingState(isLoading: true);
    });
    context
        .saveAllDeliveryAddress(parameters: widget.deliveryAddressListEntity!)
        .then((_) {
      setState(() {
        (context).setLoadingState(isLoading: false);
      });
    }, onError: (_) {
      setState(() {
        (context).setLoadingState(isLoading: false);
        (context).showErrorAlert(
            context: context,
            message: AppFailureMessages.unExpectedErrorMessage);
      });
    });
  }
}
