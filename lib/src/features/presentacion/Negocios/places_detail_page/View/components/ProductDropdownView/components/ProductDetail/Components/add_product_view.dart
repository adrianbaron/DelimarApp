import 'package:app_delivery/src/features/presentacion/widgets/Headers/text_view.dart';
import 'package:flutter/material.dart';

mixin AddProductsViewDelegate {
  addAmount();
  subtractAmount();
}

class AddProductsView extends StatelessWidget {
  AddProductsViewDelegate delegate;
  int amount;

  AddProductsView({super.key, required this.delegate, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Spacer(),
        IconButton(
            icon: const Icon(
              Icons.do_not_disturb_on,
              color: Colors.grey,
              size: 32,
            ),
            onPressed: () {
              delegate.subtractAmount();
            }),
        const SizedBox(width: 8),
        TextView(texto: "${amount}", fontSize: 18),
        const SizedBox(width: 8),
        IconButton(
            icon: const Icon(
              Icons.add_circle,
              color: Colors.orange,
              size: 32,
            ),
            onPressed: () {
              delegate.addAmount();
            }),
        const Spacer()
      ],
    );
  }
}
