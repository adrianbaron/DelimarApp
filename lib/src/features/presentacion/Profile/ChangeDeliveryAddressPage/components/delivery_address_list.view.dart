import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/Entidades/DeliveryAddress/delivery_address_entity.dart';
import 'package:app_delivery/src/features/presentacion/widgets/TextFormField/CustonTextFormField.dart';
import 'package:app_delivery/src/utils/styles/box_decoration_shadow.dart';
import 'package:flutter/material.dart';

mixin DeliveryAddressViewDelegate {
  cardTapped(
      {required BuildContext context,
      required DeliveryAddressEntity deliveryAddressEntity});
}

class DeliveryAddressListView extends StatelessWidget
    with TextFormFieldDelegate {
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
  Widget build(BuildContext context) {
    return Column(
      children: getDeliveryAddressWidgetList(context),
    );
  }

  List<Widget> getDeliveryAddressWidgetList(BuildContext context) {
    if (deliveryAddressListEntity == null) {
      return [];
    }

    return deliveryAddressListEntity?.deliveryAddressList
            .map((deliveryAddressEntity) {
          return GestureDetector(
            onTap: () {
              delegate?.cardTapped(
                  context: context,
                  deliveryAddressEntity: deliveryAddressEntity);
            },
            child: CustomTextFormField(
              delegate: this,
              hintext: '',
              textFormFieldType: CustomTextFormFieldType.email,
              decoration: defaultTextFieldDecoration,
              labelValue: deliveryAddressEntity.alias.toUpperCase(),
              initialValue: deliveryAddressEntity.street,
              enabled: false,
            ),
          );
        }).toList() ??
        [];
  }

  @override
  onChanged(
      {required String newValue,
      required CustomTextFormFieldType customTextFormFieldType}) {
    // TODO: implement onChanged
    throw UnimplementedError();
  }
}
