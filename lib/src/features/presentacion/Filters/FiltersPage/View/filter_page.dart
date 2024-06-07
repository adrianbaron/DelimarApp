import 'package:app_delivery/src/Base/Views/BaseView.dart';
import 'package:app_delivery/src/features/logica/Entidades/Places/PlaceList/filters_model_entity.dart';
import 'package:app_delivery/src/features/presentacion/ErrorView/error_view.dart';
import 'package:app_delivery/src/features/presentacion/Filters/FiltersPage/View/components/filter_page_content_view.dart';
import 'package:app_delivery/src/features/presentacion/Filters/FiltersPage/ViewModel/filsters_page_view_model.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/text_view.dart';
import 'package:flutter/material.dart';

mixin FilterPageDelegate {
  applyFilters({ required FiltersModelEntity filters });
}

class FilterPage extends StatefulWidget {

  final FilterPageDelegate? delegate;

  FilterPage({ Key? key, this.delegate }) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> with BaseView {

  FilterPageViewModel viewModel;

  _FilterPageState({ FilterPageViewModel? filterPageViewModel }) : viewModel = filterPageViewModel ?? DefaultFilterPageViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        title: const TextView(texto: 'Filters', fontWeight: FontWeight.w600),
        leading: Container(
            padding: const EdgeInsets.only(top: 20, left: 9.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  viewModel.filtersModel.resetFilters();
                });
              },
              child: const TextView(
                  texto: 'Reset',
                  fontWeight: FontWeight.w500,
                  fontSize: 17.0),
            )),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              widget.delegate?.applyFilters(filters: viewModel.filtersModel);
            },
            child: Container(
                padding: const EdgeInsets.only(top: 20, right: 10.0),
                child: const TextView(
                    texto: 'Done',
                    color: Colors.orange,
                    fontWeight: FontWeight.w500,
                    fontSize: 17.0)),
          )
        ],
      ),
      body: FutureBuilder(
          future: viewModel.viewInitState(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch(snapshot.connectionState) {
              case ConnectionState.waiting:
                return loadingView;
              case ConnectionState.done:
                switch(snapshot.data) {
                  case FilterPageViewModelState.viewLoadedState:
                    return FilterPageContentView(viewModel: viewModel);
                  default:
                    return ErrorView();
                }
              default:
                return loadingView;
            }
          }),
    );
  }
}
