import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/Entidades/DeliveryAddress/delivery_address_entity.dart';
import 'package:app_delivery/src/features/presentacion/MainCordinator/MainCordinator.dart';
import 'package:app_delivery/src/features/presentacion/Profile/ChangeDeliveryAddressPage/components/delivery_address_list.view.dart';
import 'package:app_delivery/src/utils/styles/box_decoration_shadow.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/extensions/screem_size.dart';

class ChangeDeliveryAddressContentView extends StatelessWidget with DeliveryAddressViewDelegate, BaseView {

  DeliveryAddressListEntity? deliveryAddressEntity;
  BaseViewStateDelegate? viewStateDelegate;

  ChangeDeliveryAddressContentView({ Key? key,
                                     this.deliveryAddressEntity,
                                     this.viewStateDelegate }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(delegate: SliverChildListDelegate(
            [
              const SizedBox(height: 16),
              deliveryAddressEntity?.hasDeliveryAddress() ?? false ? Container(
                decoration: getBoxDecorationWithShadows(),
                width: getScreenWidth(context: context),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    DeliveryAddressListView(delegate: this,
                                            deliveryAddressListEntity: deliveryAddressEntity,
                                            viewStateDelegate: viewStateDelegate)
                  ],
                ),
              ) : Container()
            ]
        ))
      ],
    );
  }

  @override
  cardTapped({ required BuildContext context,
               required DeliveryAddressEntity deliveryAddressEntity}) {
    coordinator.showAddEditDeliveryAddress(context: context,
                                           isForEditing: true,
                                           deliveryAddressEntity: deliveryAddressEntity,
                                           viewStateDelegate: viewStateDelegate);
  }
}
