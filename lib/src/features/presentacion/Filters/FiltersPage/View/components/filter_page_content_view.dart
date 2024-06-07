import 'package:app_delivery/src/features/presentacion/Filters/FiltersPage/View/components/cuisines_filter.dart';
import 'package:app_delivery/src/features/presentacion/Filters/FiltersPage/View/components/list_tile_checked.dart';
import 'package:app_delivery/src/features/presentacion/Filters/FiltersPage/View/components/price_filter.dart';
import 'package:app_delivery/src/features/presentacion/Filters/FiltersPage/ViewModel/filsters_page_view_model.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/text_view.dart';
import 'package:flutter/material.dart';

class FilterPageContentView extends StatefulWidget {
  FilterPageViewModel viewModel;

  FilterPageContentView({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<FilterPageContentView> createState() => _FilterPageContentViewState();
}

class _FilterPageContentViewState extends State<FilterPageContentView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 20.0, left: 15.0),
            child: const TextView(
                texto: 'COLLECTIONS',
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 17.0),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: CuisinesFilter(viewModel: widget.viewModel)),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 15.0, bottom: 5.0, left: 15.0),
            child: const TextView(
                texto: 'FILTER',
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 17.0),
          ),
          _filterContainer(),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 15.0, bottom: 5.0, left: 15.0),
            child: const TextView(
                texto: 'MAX PRICE',
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 17.0),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: PriceFilter()),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 25.0, bottom: 5.0, left: 15.0),
            child: const TextView(
                texto: 'SORT BY',
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 17.0),
          ),
          _sortByContainer(),
          const SizedBox(height: 50)
        ]))
      ],
    );
  }

  Widget _sortByContainer() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            ListTileCheck(
              texto: 'Most Popular',
              isActive: widget.viewModel.filtersModel.mostPopular,
              func: () {
                setState(() {
                  widget.viewModel.filtersModel.mostPopular =
                      !widget.viewModel.filtersModel.mostPopular;
                  widget.viewModel.filtersModel.costLowToHigh = false;
                  widget.viewModel.filtersModel.costHighToLow = false;
                });
              },
            ),
            ListTileCheck(
              texto: 'Cost Low to High',
              isActive: widget.viewModel.filtersModel.costLowToHigh,
              func: () {
                setState(() {
                  widget.viewModel.filtersModel.costLowToHigh =
                      !widget.viewModel.filtersModel.costLowToHigh;
                  widget.viewModel.filtersModel.mostPopular = false;
                  widget.viewModel.filtersModel.costHighToLow = false;
                });
              },
            ),
            ListTileCheck(
              texto: 'Cost High to Low',
              isActive: widget.viewModel.filtersModel.costHighToLow,
              func: () {
                setState(() {
                  widget.viewModel.filtersModel.costHighToLow =
                      !widget.viewModel.filtersModel.costHighToLow;
                  widget.viewModel.filtersModel.mostPopular = false;
                  widget.viewModel.filtersModel.costLowToHigh = false;
                });
              },
            )
          ],
        ));
  }

  Widget _filterContainer() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            ListTileCheck(
              texto: 'Open Now',
              isActive: widget.viewModel.filtersModel.openNow,
              func: () {
                setState(() => {
                      widget.viewModel.filtersModel.openNow =
                          !widget.viewModel.filtersModel.openNow
                    });
              },
            ),
            ListTileCheck(
              texto: 'Alcohol Served',
              isActive: widget.viewModel.filtersModel.alcoholServed,
              func: () {
                setState(() => {
                      widget.viewModel.filtersModel.alcoholServed =
                          !widget.viewModel.filtersModel.alcoholServed
                    });
              },
            )
          ],
        ));
  }
}
