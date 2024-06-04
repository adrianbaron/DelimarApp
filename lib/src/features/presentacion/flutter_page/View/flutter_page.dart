import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/presentacion/flutter_page/View/widgets/cocina_filters.dart';
import 'package:app_delivery/src/features/presentacion/flutter_page/View/widgets/list_cheked.dart';
import 'package:app_delivery/src/features/presentacion/flutter_page/View/widgets/precio_widget.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/header_text.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  FilterPage({super.key});

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  bool topRated = false;
  bool nearMe = false;
  bool costHightToLow = false;
  bool costLowToHight = false;
  bool mostPopular = false;
  //
  bool openNow = false;
  bool creditCards = false;
  bool alcoholServed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              alignment: Alignment.centerLeft,
              margin:
                  const EdgeInsets.only(top: 15.0, bottom: 10.0, left: 10.0),
              child: headerText(
                  texto: 'COCINAS',
                  color: gris,
                  fontWeight: FontWeight.w400,
                  fontSize: 17.0),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Establecer el ancho máximo disponible
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: const CocinaFilters(),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin:
                  const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
              child: headerText(
                  texto: 'ORDENAR POR',
                  color: gris,
                  fontWeight: FontWeight.w400,
                  fontSize: 17.0),
            ),
            _sortByContainer(),
            Container(
              alignment: Alignment.centerLeft,
              margin:
                  const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
              child: headerText(
                  texto: 'FILTROS',
                  color: gris,
                  fontWeight: FontWeight.w600,
                  fontSize: 17.0),
            ),
            _filterContainer(),
            Container(
              alignment: Alignment.centerLeft,
              margin:
                  const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
              child: headerText(
                  texto: 'PRECIO',
                  color: gris,
                  fontWeight: FontWeight.w600,
                  fontSize: 17.0),
            ),
            PrecioFilter(),
          ]))
        ],
      ),
    );
  }

  Widget _sortByContainer() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            ListTileCheck(
              texto: 'Mas pedido',
              isActive: topRated,
              func: () {
                setState(() {
                  topRated = !topRated;
                });
              },
            ),
            ListTileCheck(
              texto: 'Cost Hight To Low',
              isActive: costHightToLow,
              func: () {
                setState(() {
                  costHightToLow = !costHightToLow;
                });
              },
            ),
            ListTileCheck(
              texto: 'Cost Low To Hight',
              isActive: costLowToHight,
              func: () {
                setState(() {
                  costLowToHight = !costLowToHight;
                });
              },
            ),
          ],
        ));
  }

  Widget _filterContainer() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            ListTileCheck(
              texto: 'Abiertos ahora',
              isActive: openNow,
              func: () {
                setState(() {
                  openNow = !openNow;
                });
              },
            ),
            ListTileCheck(
              texto: 'Credits Cards',
              isActive: creditCards,
              func: () {
                setState(() {
                  creditCards = !creditCards;
                });
              },
            ),
            ListTileCheck(
              texto: 'AlcoholServer',
              isActive: alcoholServed,
              func: () {
                setState(() {
                  alcoholServed = !alcoholServed;
                });
              },
            ),
          ],
        ));
  }
}

PreferredSizeWidget? _appBar(BuildContext context) {
  return AppBar(
    elevation: 0.5,
    backgroundColor: Colors.white,
    title: headerText(
        texto: 'Filtros', fontWeight: FontWeight.w600, fontSize: 20.0),
    centerTitle: true, // Esta línea centra el título del AppBar
    leading: Container(
      padding: const EdgeInsets.only(
          top: 20, left: 7.0), // Ajusta el espacio del botón Limpiar
      child: headerText(
        texto: 'Reset',
        fontWeight: FontWeight.w500,
        fontSize: 17.0,
      ),
    ),
    actions: [
      GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: const EdgeInsets.only(top: 20, right: 10.0),
          child: headerText(
            texto: 'Hecho',
            color: Colors.orange, // Corregí el nombre del color
            fontWeight: FontWeight.w500,
            fontSize: 17.0,
          ),
        ),
      ),
    ],
  );
}
