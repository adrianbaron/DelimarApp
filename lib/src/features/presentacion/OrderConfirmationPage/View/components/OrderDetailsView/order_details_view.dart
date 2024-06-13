import 'dart:math';

import 'package:app_delivery/src/features/logica/Entidades/Order/order_entity.dart';
import 'package:app_delivery/src/features/logica/Entidades/Places/PlaceList/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/widgets/ProductSelectedCardView/Model/product_selected_card_model.dart';
import 'package:app_delivery/src/features/presentacion/widgets/ProductSelectedCardView/View/product_selected_card_view.dart';
import 'package:app_delivery/src/utils/extensions/iterable_extensions.dart';
import 'package:app_delivery/src/utils/styles/box_decoration_shadow.dart';
import 'package:flutter/material.dart';

class OrderDetailsView extends StatefulWidget {
  final OrderEntity order;
  ProductSelectedCardViewDelegate delegate;
  OrderDetailsView({super.key, required this.order, required this.delegate});

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          decoration: getBoxDecorationWithShadows(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PlaceNameView(order: widget.order),
              _PlaceLocationView(order: widget.order),
              _ProductsInOrderView(
                  order: widget.order, delegate: widget.delegate),
            ],
          ),
        )
      ],
    );
  }
}

class _PlaceNameView extends StatelessWidget {
  final OrderEntity order;
  const _PlaceNameView({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, top: 16),
      child: Text(order.place.placeName,
          style: const TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
}

class _PlaceLocationView extends StatelessWidget {
  final OrderEntity order;
  const _PlaceLocationView({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.translate(
            offset: const Offset(0, 4),
            child: const Icon(
              Icons.location_on,
              color: Colors.grey,
              size: 16,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 4),
            width: 320,
            child: Text(order.place.address,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}

class _ProductsInOrderView extends StatelessWidget {
  final OrderEntity order;
  ProductSelectedCardViewDelegate delegate;
  _ProductsInOrderView(
      {super.key, required this.order, required this.delegate});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
      child: Column(
        children: _getProductsCardsViews(),
      ),
    );
  }

  List<Widget> _getProductsCardsViews() {
    return order.products.map((product) {
      return ProductSelectedCardView(
          model: ProductSelectedCardModel(
              id: product.id,
              photoUrl: product.imgs.first,
              price: product.productPrice,
              quantity: product.amount,
              productName: product.productName,
              extras: _getExtrasFrom(options: product.options)),
          delegate: delegate,
          isTheLastProduct: product.id == order.products.last.id);
    }).toList();
  }

  String _getExtrasFrom({required List<PlaceProductExtrasEntity> options}) {
    var extrasJoined = "";
    options.forEach((option) {
      extrasJoined = option.extras
          .map((extra) {
            if (extra.isSelected) {
              return extra.title;
            }
          })
          .compactMap()
          .join(", ");
    });
    return extrasJoined;
  }
}
