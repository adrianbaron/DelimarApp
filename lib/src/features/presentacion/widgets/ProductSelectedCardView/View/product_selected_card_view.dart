import 'package:app_delivery/src/features/presentacion/widgets/ProductSelectedCardView/Model/product_selected_card_model.dart';
import 'package:app_delivery/src/utils/extensions/screem_size.dart';
import 'package:app_delivery/src/utils/helpers/CheckoutHelper/check_out_helper.dart';
import 'package:flutter/material.dart';

mixin ProductSelectedCardViewDelegate {
  updateAmount({required String productId, required int amount});
}

class ProductSelectedCardView extends StatefulWidget {
  final ProductSelectedCardModel model;
  bool? isTheLastProduct = false;
  ProductSelectedCardViewDelegate delegate;

  ProductSelectedCardView(
      {Key? key,
      required this.model,
      this.isTheLastProduct,
      required this.delegate})
      : super(key: key);

  @override
  State<ProductSelectedCardView> createState() =>
      _ProductSelectedCardViewState();
}

class _ProductSelectedCardViewState extends State<ProductSelectedCardView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image(
              width: getScreenWidth(context: context),
              height: 60.0,
              fit: BoxFit.cover,
              image: NetworkImage(widget.model.photoUrl)),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(CheckoutHelper.formatPriceInEuros(widget.model.price),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              Text("${widget.model.quantity}x",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.model.productName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black)),
                widget.model.extras.isEmpty
                    ? Container()
                    : Container(
                        width: getScreenWidth(context: context),
                        margin: const EdgeInsets.only(top: 5),
                        child: Text(widget.model.extras,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.black87)),
                      )
              ],
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: const Icon(
                  Icons.remove_circle,
                  color: Colors.orange,
                  size: 24,
                ),
                onPressed: () {
                  widget.delegate
                      .updateAmount(productId: widget.model.id, amount: -1);
                }),
            IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.orange,
                  size: 24,
                ),
                onPressed: () {
                  widget.delegate
                      .updateAmount(productId: widget.model.id, amount: 1);
                })
          ],
        ),
        widget.isTheLastProduct ?? false
            ? Container()
            : Divider(color: Colors.black.withOpacity(0.5))
      ],
    );
  }
}
