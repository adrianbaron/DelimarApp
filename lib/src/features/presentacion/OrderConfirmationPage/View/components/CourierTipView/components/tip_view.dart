import 'package:app_delivery/src/features/presentacion/OrderConfirmationPage/View/components/CourierTipView/courier_tip_view.dart';
import 'package:app_delivery/src/utils/helpers/CheckoutHelper/check_out_helper.dart';
import 'package:app_delivery/src/utils/styles/box_decoration_shadow.dart';
import 'package:flutter/material.dart';

class TipModel {
  final String id;
  final double tip;
  bool isSelected;

  TipModel({required this.id, required this.tip, required this.isSelected});
}

class TipView extends StatelessWidget {
  CourierTipViewDelegate? delegate;
  final TipModel model;
  TipView({super.key, required this.model, this.delegate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => delegate?.courierTipChanged(model: model),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(top: 8.0)  ,
        decoration: model.isSelected ? defaultTextFieldDecoration : borderGrayDecoration,
        child: Text(CheckoutHelper.formatPriceInEuros(model.tip), style:const TextStyle(fontSize: 17),),
      ),
    );
  }
}
