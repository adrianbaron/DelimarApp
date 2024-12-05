import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/View/components/FlexibleSpaceBar/place_detail_info_view.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/View/components/FlexibleSpaceBar/place_detail_stats_info_view.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/View/components/FlexibleSpaceBar/promo_place_detail_view.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/ViewModel/place_detail_view_model.dart';
import 'package:app_delivery/src/utils/extensions/screem_size.dart';
import 'package:flutter/material.dart';

class FlexibleSpaceBarContentView extends StatelessWidget {
  PlaceDetailViewModel viewModel;

  FlexibleSpaceBarContentView({Key? key, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Stack(
        children: [
           AnimatedContainer(
            duration: const Duration(milliseconds: 10),
            child: Image(
                width: double.infinity,
                height: getScreenHeight(context: context, multiplier: 0.48),
                fit: BoxFit.fill,
                image: NetworkImage(viewModel.place.imgs.first)),
          ),
          Container(
              decoration: const BoxDecoration(color: Colors.black45),
              width: double.infinity,
              height: getScreenHeight(context: context, multiplier: 0.42)),
          Container(
            height: getScreenHeight(context: context, multiplier: 0.42),
            margin: EdgeInsets.only(
                top: getScreenHeight(context: context, multiplier: 0.10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PromoPlaceDetailView(),
                PlaceDetailInfoView(viewModel: viewModel),
                PlaceDetailStatsInfoView(viewModel: viewModel),
              ],
            ),
          )
        ],
      ),
    );
  }
}
