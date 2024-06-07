import 'package:app_delivery/src/features/logica/Entidades/Order/order_entity.dart';
import 'package:app_delivery/src/features/logica/Entidades/Places/PlaceList/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/View/components/ProductDropdownView/components/ProductDetail/Components/ExtraSelectionFormField/extra_description_view.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/View/components/ProductDropdownView/components/ProductDetail/Components/ExtraSelectionFormField/extra_list_view.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/View/components/ProductDropdownView/components/ProductDetail/Components/ExtraSelectionFormField/product_extras_maxcount.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/ViewModel/place_detail_view_model.dart';
import 'package:flutter/material.dart';

mixin ExtraSelectionFormViewDelegate {
  updateProductForOrder({required ProductOrderEntity product});
}

class OptionsSelectionFormView extends StatelessWidget {
  PlaceDetailViewModel viewModel;
  ProductOrderEntity product;
  PlaceProductExtrasEntity extra;
  ExtraSelectionFormViewDelegate delegate;

  OptionsSelectionFormView(
      {Key? key,
      required this.extra,
      required this.viewModel,
      required this.product,
      required this.delegate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExtraDescriptionView(extra: extra),
        const SizedBox(height: 8),
        ProductExtraMaxCountView(extra: extra),
        const SizedBox(height: 16),
        ExtrasListView(
            viewModel: viewModel,
            extra: extra,
            product: product,
            delegate: delegate)
      ],
    );
  }
}
