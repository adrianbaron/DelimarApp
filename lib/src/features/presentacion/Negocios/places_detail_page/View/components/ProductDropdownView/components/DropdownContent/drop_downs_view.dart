import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/View/components/ProductDropdownView/components/DropdownContent/product_dropdowns_view.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/ViewModel/place_detail_view_model.dart';
import 'package:flutter/material.dart';

class DropDownsView extends StatelessWidget {
  PlaceDetailViewModel viewModel;

  DropDownsView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: _getProductDropdownViews(),
      ),
    );
  }

  List<Widget> _getProductDropdownViews() {
    return viewModel.place.categories.map((category) {
      return ProductDropdownView(category: category, viewModel: viewModel);
    }).toList();
  }
}
