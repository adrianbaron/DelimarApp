
import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/logica/Entidades/Order/order_entity.dart';
import 'package:app_delivery/src/features/logica/Entidades/Places/PlaceList/place_list_entity.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/View/components/ProductDropdownView/components/ProductDetail/Components/ExtraSelectionFormField/options_selection_form.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/ViewModel/place_detail_view_model.dart';
import 'package:app_delivery/src/utils/extensions/screem_size.dart';
import 'package:app_delivery/src/utils/helpers/CheckoutHelper/check_out_helper.dart';
import 'package:flutter/material.dart';

class ExtrasListView extends StatefulWidget {
  PlaceDetailViewModel viewModel;
  PlaceProductExtrasEntity extra;
  ProductOrderEntity product;
  ExtraSelectionFormViewDelegate delegate;

  ExtrasListView(
      {Key? key,
      required this.viewModel,
      required this.extra,
      required this.product,
      required this.delegate})
      : super(key: key);

  @override
  State<ExtrasListView> createState() => _ExtrasListViewState();
}

class _ExtrasListViewState extends State<ExtrasListView>
    with ExtraViewDelegate {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(children: _getExtrasList()),
    );
  }

  List<Widget> _getExtrasList() {
    return widget.extra.extras
        .map((extra) => ExtraView(
            extra: extra,
            canAddMoreExtras: _canAddMoreExtras(optionId: widget.extra.id),
            delegate: this))
        .toList();
  }

  @override
  updateExtraInProductInOrder(
      {required String extraId, required bool isSelected}) {
    setState(() {
      widget.product.options = widget.product.options.map((extra) {
        var newExtra = extra;
        newExtra.selectExtra(extraId: extraId, isSelected: isSelected);
        return newExtra;
      }).toList();
      widget.extra.selectExtra(extraId: extraId, isSelected: isSelected);
      widget.delegate.updateProductForOrder(product: widget.product);
    });
  }

  bool _canAddMoreExtras({required String optionId}) {
    if (widget.product.options.isNotEmpty) {
      List<PlaceProductExtrasEntity> option = widget.product.options
          .where((option) => option.id == optionId)
          .toList();
      if (option.isNotEmpty) {
        int maxExtras = option.first.maxExtras;
        var extras = widget.product.options
            .map((option) => option.extras)
            .toList()
            .first;
        int extrasSelectedCount =
            extras.where((extra) => extra.isSelected == true).length;
        return extrasSelectedCount < maxExtras;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }
}

mixin ExtraViewDelegate {
  updateExtraInProductInOrder(
      {required String extraId, required bool isSelected});
}

enum ExtraState { disabled, available, added }

class ExtraView extends StatelessWidget {
  PlaceProductExtra extra;
  ExtraViewDelegate? delegate;
  bool canAddMoreExtras;

  ExtraView(
      {Key? key,
      required this.extra,
      required this.canAddMoreExtras,
      this.delegate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            SizedBox(
              width: getScreenHeight(context: context, multiplier: 0.29),
              child: Text(
                extra.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: _getTitleColorFromState()),
              ),
            ),
            const SizedBox(width: 4),
            extra.price > 0
                ? Text(
                    "+${CheckoutHelper.formatPriceInEuros(extra.price)}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: _getPriceColorFromState()),
                  )
                : Container()
          ],
        ),
        const Spacer(),
        IconButton(
            icon: Icon(
              _getIconDataFromState(),
              color: _getIconColorFromState(),
              size: 24,
            ),
            onPressed: () {
              _viewModelAddOrRemoveExtra();
            })
      ],
    );
  }

  Color _getTitleColorFromState() {
    if (!canAddMoreExtras) {
      return extra.isSelected ? Colors.black : gris;
    } else {
      return Colors.black;
    }
  }

  Color _getPriceColorFromState() {
    if (!canAddMoreExtras) {
      return extra.isSelected ? orange : gris;
    } else {
      return orange;
    }
  }

  IconData _getIconDataFromState() {
    if (canAddMoreExtras) {
      return extra.isSelected ? Icons.check_circle : Icons.add_circle;
    } else {
      return extra.isSelected ? Icons.check_circle : Icons.add;
    }
  }

  Color _getIconColorFromState() {
    if (!canAddMoreExtras) {
      return extra.isSelected ? orange : gris;
    } else {
      return orange;
    }
  }

  _viewModelAddOrRemoveExtra() {
    if (canAddMoreExtras) {
      delegate?.updateExtraInProductInOrder(
          extraId: extra.id, isSelected: !extra.isSelected);
    } else {
      if (extra.isSelected) {
        delegate?.updateExtraInProductInOrder(
            extraId: extra.id, isSelected: !extra.isSelected);
      }
    }
  }
}
