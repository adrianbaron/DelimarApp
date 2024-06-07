import 'package:app_delivery/src/features/logica/Entidades/Places/PlaceList/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/View/components/ProductDropdownView/components/DropdownContent/RowsViews/prodcut_unselected_row_view.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/View/components/ProductDropdownView/components/DropdownContent/RowsViews/product_selected_row_view.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/ViewModel/place_detail_view_model.dart';
import 'package:app_delivery/src/utils/extensions/screem_size.dart';
import 'package:flutter/material.dart';

class ProductCardView extends StatelessWidget {
  bool isSelected;
  PlaceProductEntity product;
  PlaceDetailViewModel viewModel;

  ProductCardView(
      {Key? key,
      required this.product,
      required this.isSelected,
      required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image(
              width: getScreenWidth(context: context),
              height: 50.0,
              fit: BoxFit.cover,
              image: NetworkImage(product.imgs.first)),
        ),
        isSelected
            ? ProductSelectedRowView(viewModel: viewModel, product: product)
            : ProductUnSelectedRowView(viewModel: viewModel, product: product),
        Divider(color: Colors.black.withOpacity(0.5))
      ],
    );
  }
}
