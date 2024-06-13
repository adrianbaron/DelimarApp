import 'package:app_delivery/src/features/presentacion/OrderConfirmationPage/View/components/CourierTipView/components/tip_view.dart';

import 'package:app_delivery/src/utils/styles/box_decoration_shadow.dart';
import 'package:flutter/material.dart';

mixin CourierTipViewDelegate {
  courierTipChanged({required TipModel model});
}

class CourierTipView extends StatefulWidget {
  CourierTipViewDelegate? delegate;

  //final TipModel model;

  CourierTipView({Key? key, this.delegate}) : super(key: key);

  @override
  State<CourierTipView> createState() => _CourierTipViewState();
}

class _CourierTipViewState extends State<CourierTipView>
    with CourierTipViewDelegate {
  List<TipModel> tips = [
    TipModel(tip: 1.000, isSelected: true, id: '1'),
    TipModel(tip: 2.000, isSelected: false, id: '2'),
    TipModel(tip: 3.000, isSelected: false, id: '3'),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.all(16),
      decoration: getBoxDecorationWithShadows(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16, top: 16),
            child: const Text(
              "PROPINA AL DOMICILIO",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 16, top: 12, right: 16, bottom: 24),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: tips.map((tip) {
                  return TipView(model: tip, delegate: this);
                }).toList()),
          )
        ],
      ),
    );
  }

  @override
  courierTipChanged({required TipModel model}) {
    setState(() {
      tips = tips.map((tip) {
        var newTip = tip;
        newTip.isSelected = newTip.id == model.id ? true : false;
        return newTip;
      }).toList();
      widget.delegate?.courierTipChanged(model: model);
    });
  }
}
