import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/Colors/Colors.dart';
import 'package:app_delivery/src/features/logica/Entidades/DeliveryAddress/delivery_address_entity.dart';
import 'package:app_delivery/src/features/presentacion/MainCordinator/MainCordinator.dart';
import 'package:app_delivery/src/features/presentacion/Profile/ChangeDeliveryAddressPage/components/delivery_address_list.view.dart';
import 'package:app_delivery/src/features/presentacion/StateProviders/user_state_provider.dart';
import 'package:app_delivery/src/utils/helpers/CheckoutHelper/check_out_helper.dart';
import 'package:flutter/material.dart';


class DeliveryAddressView extends StatefulWidget {
  final BaseViewStateDelegate? viewStateDelegate;

  const DeliveryAddressView({Key? key, this.viewStateDelegate}) : super(key: key);

  @override
  State<DeliveryAddressView> createState() => _DeliveryAddressViewState();
}

class _DeliveryAddressViewState extends State<DeliveryAddressView>
    with BaseView, DeliveryAddressViewDelegate, BaseViewStateDelegate {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: (context).getDeliveryAddressList(),
      builder: (BuildContext context,
          AsyncSnapshot<DeliveryAddressListEntity?> snapshot) {
        
        if (snapshot.hasData && snapshot.data != null) {  
          if (CheckoutHelper.getMainDeliveryAddress(entity: snapshot.data!)
              .deliveryAddressList
              .isEmpty) {
            return Container();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 16, top: 16),
                  child: const Text("DIRECCIONES DE ENTREGA",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: DeliveryAddressListView(
                    delegate: this,
                    deliveryAddressListEntity:
                        CheckoutHelper.getMainDeliveryAddress(
                            entity: snapshot.data!),
                    viewStateDelegate: this),
              ),
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      coordinator
                          .showChangeDeliveryAddress(context: context)
                          .then((_) {
                        setState(() {
                          widget.viewStateDelegate?.onChange();
                        });
                      });
                    },
                    child: Container(
                        margin: const EdgeInsets.only(right: 16, top: 16),
                        child:  Text("Editar dirección de envío",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: rosa))),
                  )
                ],
              ),
             const SizedBox(height: 16)
            ],
          );
        } else {
          return Container(color: Colors.white);
        }
      },
    );
  }

  @override
  cardTapped(
      {required BuildContext context,
      required DeliveryAddressEntity deliveryAddressEntity}) {}

  @override
  void onChange() {}
}
