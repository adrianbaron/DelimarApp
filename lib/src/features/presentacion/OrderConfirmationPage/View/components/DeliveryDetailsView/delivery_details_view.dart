import 'package:app_delivery/src/features/logica/Entidades/Order/order_entity.dart';
import 'package:app_delivery/src/features/presentacion/widgets/TextFormField/CustonTextFormField.dart';
import 'package:app_delivery/src/utils/styles/box_decoration_shadow.dart';
import 'package:flutter/material.dart';

mixin DeliveryDetailsViewDelegate {
  deliveryDetailsChanged({required OrderEntity order});
}

class DeliveryDetailsView extends StatefulWidget {
  OrderEntity order;
  DeliveryDetailsViewDelegate? delegate;

  DeliveryDetailsView({super.key, required this.order, this.delegate});

  @override
  State<DeliveryDetailsView> createState() => _DeliveryDetailsViewState();
}

class _DeliveryDetailsViewState extends State<DeliveryDetailsView>
    with TextFormFieldDelegate {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: getBoxDecorationWithShadows(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(left: 16, top: 16),
              child: const Text("TIEMPO DE ENTREGA",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
          Container(
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
              decoration: defaultTextFieldDecoration,
              width: double.infinity,
              height: 52,
              child: Text(
                  widget.order.deliveryTimeIsAsap() ? "Lo antes posible" : "",
                  style: const TextStyle(fontSize: 17))),
          Container(
              margin: const EdgeInsets.only(left: 16, top: 16),
              child: const Text("NOTAS",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
          Container(
            margin: const EdgeInsets.only(
                top: 8.0, left: 16, right: 16, bottom: 24),
            child: CustomTextFormField(
              delegate: this,
              hintext: 'Ponle mucha salsa',
              textFormFieldType: CustomTextFormFieldType.notes,
              decoration: defaultTextFieldDecoration,
              initialValue: widget.order.deliveryNotes,
              enabled: true,
              minLines: 6,
              isTextArea: true,
            ),
          )
        ],
      ),
    );
  }

  @override
  onChanged(
      {required String newValue,
      required CustomTextFormFieldType customTextFormFieldType}) {
    switch (customTextFormFieldType) {
      case CustomTextFormFieldType.notes:
        widget.order.deliveryNotes = newValue;
        widget.delegate?.deliveryDetailsChanged(order: widget.order);
      default:
        break;
    }
  }
}
