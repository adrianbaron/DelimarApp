import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/View/components/BookMarkView/book_mark_view.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/View/components/FlexibleSpaceBar/flexible_space_bar_content_view.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/View/components/SharedIconView/shared_icon_view.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/ViewModel/place_detail_view_model.dart';
import 'package:app_delivery/src/features/presentacion/widgets/BackBoton/back_button.dart';
import 'package:app_delivery/src/utils/extensions/screem_size.dart';
import 'package:flutter/material.dart';

class AppBarView extends StatelessWidget {
  PlaceDetailViewModel viewModel;

  AppBarView({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: orange,
      expandedHeight: getScreenHeight(context: context, multiplier: 0.41),
      flexibleSpace: FlexibleSpaceBarContentView(viewModel: viewModel),
      leading: Builder(builder: (BuildContext context) {
        return const BackButtonView(color: Colors.white);
      }),
      actions: [
        ShareIconView(viewModel: viewModel),
        BookMarkView(viewModel: viewModel)
      ],
    );
  }
}
