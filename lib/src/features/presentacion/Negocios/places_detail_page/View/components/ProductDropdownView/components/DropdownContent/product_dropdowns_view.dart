import 'package:app_delivery/src/features/logica/Entidades/Places/PlaceList/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/View/components/ProductDropdownView/components/DropdownContent/product_dropdowns_content_view.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/ViewModel/place_detail_view_model.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Text/DoubleTextView/double_text_drown.dart';
import 'package:flutter/material.dart';

class ProductDropdownView extends StatefulWidget {
  final PlaceCategoryEntity category;
  PlaceDetailViewModel viewModel;
  bool isExpanded = true;

  ProductDropdownView({ Key? key,
                        required this.category, 
                        required this.viewModel });

  @override
  State<ProductDropdownView> createState() => _ProductDropdownViewState();
}

class _ProductDropdownViewState extends State<ProductDropdownView> with DoubleTextDropdownViewDelegate {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      DoubleTextDropdownView(header: widget.category.categoryName,
                             delegate: this,
                             isExpanded: widget.isExpanded, 
                             dropdownRightText: "${widget.category.products.length}",),
      widget.isExpanded ? Transform.translate(
                                   offset: const Offset(0, -20), 
                                   child: ProductDropdownContentView(viewModel: widget.viewModel, 
                                                                     products: widget.category.products))
                        : Container(),
    ]);
  }

  @override
  dropDownTapped({ required bool isExpanded }) {
    setState(() {
      widget.isExpanded = isExpanded; 
    });
  }
}



