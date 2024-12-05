import 'package:app_delivery/src/features/logica/Entidades/Places/PlaceList/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/View/components/ProductDropdownView/components/ProductDetail/product_detail.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/ViewModel/place_detail_view_model.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/text_view.dart';
import 'package:app_delivery/src/utils/extensions/screem_size.dart';
import 'package:app_delivery/src/utils/helpers/CheckoutHelper/check_out_helper.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class ProductUnSelectedRowView extends StatefulWidget {
  PlaceProductEntity product;
  PlaceDetailViewModel viewModel;

  ProductUnSelectedRowView({ Key? key, 
                          required this.product, 
                          required this.viewModel }) : super(key: key);

  @override
  State<ProductUnSelectedRowView> createState() => _ProductUnSelectedRowViewState();
}

class _ProductUnSelectedRowViewState extends State<ProductUnSelectedRowView> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showProductDetailView(),
      child: Column(
        children: [
          AvatarGlow(
            glowColor: Colors.orange,
            child: Row(
                children: [
                  Container(
                    width: getScreenWidth(context: context, multiplier: 0.75),
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      widget.product.productName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: TextView(
                        texto: CheckoutHelper.formatPriceInEuros(widget.product.productPrice),
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                        color: Colors.black),
                  )
                ],
              ),
          ),
            Row(
              children: [
                SizedBox(
                  width: getScreenWidth(context: context, multiplier: 0.79),
                  child: Text(
                    widget.product.productDescription,
                    
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(fontWeight: FontWeight.w500, 
                    fontSize: 15,color: Colors.orange),
                  ),
                ),
                /* IconButton(
                      icon: const Icon(
                        Icons.add_circle,
                        color:  Colors.orange,
                        size: 24,
                      ),
                      onPressed: () {}),
                      */
                
              ],
            )
        ],
      ),
    );
  }

  void _showProductDetailView() {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        builder: (context) {
          return ProductDetailView(product: widget.product, viewModel: widget.viewModel);
        }
    );
  }

}
