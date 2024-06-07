import 'package:app_delivery/src/features/logica/Entidades/Places/PlaceList/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/View/components/ProductCardView/product_card_view.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/ViewModel/place_detail_view_model.dart';
import 'package:app_delivery/src/utils/extensions/screem_size.dart';
import 'package:flutter/material.dart';

class ProductDropdownContentView extends StatefulWidget {
  PlaceDetailViewModel viewModel;
  List<PlaceProductEntity> products;

  ProductDropdownContentView(
      {Key? key, required this.viewModel, required this.products})
      : super(key: key);

  @override
  State<ProductDropdownContentView> createState() =>
      _ProductDropdownContentViewState();
}

class _ProductDropdownContentViewState
    extends State<ProductDropdownContentView> {
  bool isItemInOrderList = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 16),
        child: SizedBox(
          width: getScreenWidth(context: context),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _getProductCardsViews()),
        ));
  }

  List<Widget> _getProductCardsViews() {
    return widget.products.map((product) {
      return ProductCardView(
          isSelected: widget.viewModel.isProductInOrder(productId: product.id),
          product: product,
          viewModel: widget.viewModel);
    }).toList();
  }
}
