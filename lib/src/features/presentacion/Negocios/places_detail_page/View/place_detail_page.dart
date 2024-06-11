import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/Entidades/Order/order_entity.dart';
import 'package:app_delivery/src/features/presentacion/ErrorView/error_view.dart';
import 'package:app_delivery/src/features/presentacion/MainCordinator/MainCordinator.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/View/components/ProductDropdownView/components/AppBarView/app_bar_view.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/View/components/ProductDropdownView/components/DropdownContent/drop_downs_view.dart';
import 'package:app_delivery/src/features/presentacion/Negocios/places_detail_page/ViewModel/place_detail_view_model.dart';
import 'package:app_delivery/src/features/presentacion/widgets/FAB/fab_rounded_rectangle_view.dart';

import 'package:app_delivery/src/features/presentacion/widgets/Headers/header_double.dart';
import 'package:app_delivery/src/features/presentacion/widgets/RatingsView/ratings_view.dart';
import 'package:app_delivery/src/features/presentacion/widgets/RatingsView/your_ratings.dart';
import 'package:app_delivery/src/utils/helpers/CheckoutHelper/check_out_helper.dart';
import 'package:flutter/material.dart';

class PlaceDetailPage extends StatefulWidget {
  PlaceDetailViewModel viewModel;

  PlaceDetailPage({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<PlaceDetailPage> createState() => _PlaceDetailPageState();
}

class _PlaceDetailPageState extends State<PlaceDetailPage> with BaseView {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.viewModel.orderStream,
      builder: (BuildContext context, AsyncSnapshot<OrderEntity> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return loadingView;
          default:
            if (snapshot.data != null) {
              return Scaffold(
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: FABRoundedRectangleView(
                    text:
                        'Pedir ${snapshot.data?.products.length} por ${CheckoutHelper.formatPriceInEuros(snapshot.data?.totalAmount ?? 0.0)}',
                    onPressed: () {
                      coordinator.showOrderConfimationPage(
                          context: context, order: snapshot.data!).then((order) {
                        if (order!= null && order is OrderEntity) {
                          widget.viewModel.updateOrder(order: order);
                        }
                      });
                    },
                    isHidden: snapshot.data?.products.isEmpty ?? true),
                body: CustomScrollView(
                  slivers: <Widget>[
                    AppBarView(viewModel: widget.viewModel),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      DropDownsView(viewModel: widget.viewModel),
                      const SizedBox(height: 15.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: DoubleTextView(
                            textHeader: "Reseñas",
                            textAction: "Ver todas",
                            textActionTapped: () {
                              coordinator.showRatingsPage(
                                  context: context,
                                  placeRatings:
                                      widget.viewModel.place.placeRatings);
                            }),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: RatingsView(
                            placeRatings: widget.viewModel.place.placeRatings
                                .take(4)
                                .toList()),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: userHasRatingInThisPlace()
                            ? YourRatingView()
                            : Container(),
                      ),
                      const SizedBox(height: 100.0)
                    ]))
                  ],
                ),
              );
            } else {
              return ErrorView();
            }
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.viewModel.dispose();
  }

  bool userHasRatingInThisPlace() {
    String userUid = MainCoordinator.sharedInstance?.userUid ?? "";
    return widget.viewModel.place.placeRatings
        .where((rating) => rating.userId == userUid)
        .toList()
        .isNotEmpty;
  }
}
