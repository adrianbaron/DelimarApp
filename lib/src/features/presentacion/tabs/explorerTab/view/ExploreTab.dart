import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/presentacion/ErrorView/error_view.dart';
import 'package:app_delivery/src/features/presentacion/tabs/explorerTab/exploreTabViewModel/explore_tab_view_model.dart';
import 'package:app_delivery/src/features/presentacion/tabs/explorerTab/view/Components/explore_tab_content_view.dart';
import 'package:app_delivery/src/services/GeolocationService/Service/GeolocationService.dart';
import 'package:flutter/material.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> with BaseView {
  final ExploreViewModel viewModel;
  _ExploreTabState({ExploreViewModel? exploreViewModel})
      : viewModel = exploreViewModel ?? DefaultExploreViewModel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FutureBuilder(
            future: viewModel.viewInitState(),
            builder: (BuildContext context,
                AsyncSnapshot<ExploreViewModelState> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return loadingView;

                case ConnectionState.done:
                  // TODO: gestionar error de geolocalizacion
                  if (snapshot.error ==
                          GeolocationErrorsMessages.locationPermissionDenied ||
                      snapshot.error ==
                          GeolocationErrorsMessages
                              .locationPermissionDeniedForever) {
                    var errorView = ErrorView();
                    errorView.isLocationDeniedError = true;
                    return errorView;
                  }

                  switch (snapshot.data) {
                    case ExploreViewModelState.viewLoadedState:
                      return ExploreTabContentView(viewModel: viewModel);
                    default:
                      return ErrorView();
                  }
                default:
                  return loadingView;
              }
            }));
  }
}
