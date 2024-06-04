import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/presentacion/widgets/BackBoton/back_button.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/header_double.dart';
import 'package:flutter/material.dart';

import '../../widgets/Headers/header_text.dart';

class PlaceDetailPage extends StatelessWidget {
  const PlaceDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          label: headerText(
              texto: "añadir a la cesta 12.000",
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 17.0)),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: orange,
            expandedHeight: 350,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  const Image(
                    width: double.infinity,
                    height: 397,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1599655345131-6eb73b81d8d6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=986&q=80'),
                  ),
                  Container(
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 1.5)),
                      width: double.infinity,
                      height: 340),
                  Wrap(
                    children: [
                      _promoButon(),
                      _infoPlace(),
                      _infoPlaceStats(),
                      //_offerBanner(),
                    ],
                  )
                ],
              ),
            ),
            leading: Builder(builder: (BuildContext context) {
              return BackButtonView(color: Colors.white);
            }),
            actions: [
              Container(
                margin: const EdgeInsets.all(10),
                child: const Image(
                  width: 28,
                  height: 28,
                  image: AssetImage('assets/compartir.png'),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.bookmark_border,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {},
              )
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _headers(texto: "Lo mas rico"),
              _sliderCards(),
              _headers(texto: "Full Menu"),
              _menuList(context),
              _headers(texto: 'Reseñas'),
              _review(),
              _headers(texto: "Tu reseña"),
              _yourRating(),
              const SizedBox(
                height: 120.0,
              )
            ]),
          )
        ],
      ),
    );
  }
}

Widget _promoButon() {
  return Container(
    margin: const EdgeInsets.only(top: 120.0, left: 30.0, right: 15.0),
    /*child: Row(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            elevation: 0.5,
            shape: const StadiumBorder(),
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
          ),
          child: headerText(
            texto: "Domicilio gratis",
            fontSize: 12.0,
            color: Colors.white,
          ),
        ),
      ],
    ),*/
  );
}

Widget _infoPlace() {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        margin: const EdgeInsets.symmetric(vertical: 7.0),
        child: headerText(
            texto: "El mejor sabor de los camarones asados",
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 35.0),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Row(
          children: [
            Icon(Icons.location_on, color: gris),
            headerText(
                texto: "Calle 4a 19-45, Barrio Gaitan",
                color: gris,
                fontWeight: FontWeight.w500,
                fontSize: 15.0),
          ],
        ),
      )
    ],
  );
}

Widget _infoPlaceStats() {
  return Container(
    margin: const EdgeInsets.only(top: 26.0),
    padding: const EdgeInsets.symmetric(horizontal: 40.0),
    height: 70.0,
    decoration: const BoxDecoration(
        border: Border(
            top: BorderSide(color: Colors.white),
            bottom: BorderSide(color: Colors.white))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.star, color: Colors.white, size: 19.0),
                headerText(
                    texto: '4.7',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0)
              ],
            ),
            headerText(
                texto: "245 Ratings",
                color: gris,
                fontWeight: FontWeight.w500,
                fontSize: 15.0)
          ],
        ),
        Container(
          height: 40,
          decoration: const BoxDecoration(
              border: Border(right: BorderSide(color: Colors.white))),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.bookmark, color: Colors.white, size: 19.0),
                headerText(
                    texto: '234k',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0)
              ],
            ),
            headerText(
                texto: "Favorito",
                color: gris,
                fontWeight: FontWeight.w500,
                fontSize: 15.0)
          ],
        ),
        Container(
          height: 40,
          decoration: const BoxDecoration(
              border: Border(right: BorderSide(color: Colors.white))),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.photo, color: Colors.white, size: 19.0),
                headerText(
                    texto: '13',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0)
              ],
            ),
            headerText(
                texto: "Fotos",
                color: gris,
                fontWeight: FontWeight.w500,
                fontSize: 15.0)
          ],
        ),
      ],
    ),
  );
}

Widget _offerBanner() {
  return Container(
    color: const Color.fromRGBO(255, 237, 214, 1.0),
    padding: const EdgeInsets.all(8),
    height: 90,
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerText(
                texto: "Este baner es para algo",
                color: orange,
                fontWeight: FontWeight.bold,
                fontSize: 15.0),
            headerText(
                texto: "Este baner es para algo \n pero con mucho mas taxto",
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 13.0),
          ],
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            elevation: 0.5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
          ),
          child: headerText(
            texto: "Ordenar",
            fontSize: 13.0,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

Widget _headers({texto = String}) {
  return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DoubleTextView(textHeader: texto, textAction: ""));
}

Widget _sliderCards() {
  return Container(
    height: 210,
    padding: const EdgeInsets.only(left: 10),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return _cards();
      },
    ),
  );
}

Widget _cards() {
  return Container(
    margin: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: const Image(
            width: 200.0,
            height: 100.0,
            fit: BoxFit.cover,
            image: NetworkImage(
                'https://images.unsplash.com/photo-1562967915-daced602d43d?q=80&w=1773&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'), // Ejemplo de URL de imagen
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: headerText(
              texto: "Arroz de camaron",
              fontWeight: FontWeight.bold,
              fontSize: 15.0),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: headerText(
              texto: "10.000",
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              color: gris),
        ),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: headerText(
                  texto: "Selecciona",
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                  color: orange),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 90),
              child: const Image(
                width: 20.0,
                height: 20.0,
                fit: BoxFit.cover,
                image: AssetImage('assets/anadir.png'),
              ),
            )
          ],
        )
      ],
    ),
  );
}

Widget _menuList(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(left: 10.0),
    child: Column(
      children: [
        _menuItem(context, 'Ceviches', '2'),
        _menuItem(context, 'Cazuelas', '5'),
        _menuItem(context, 'Langostas', '5'),
        _menuItem(context, 'Sushi', '5'),
      ],
    ),
  );
}

Widget _menuItem(BuildContext context, String texto, String itemCount) {
  return Container(
    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: gris))),
    child: Column(
      children: [
        ListTile(
          title: headerText(
              texto: texto, fontWeight: FontWeight.w300, fontSize: 17.0),
          trailing: headerText(
              texto: itemCount, fontWeight: FontWeight.w300, fontSize: 17.0),
        ),
        _sliderCards()
      ],
    ),
  );
}

Widget _review() {
  return Container(
    height: 135,
    padding: const EdgeInsets.only(left: 10),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return _cardsReview();
      },
    ),
  );
}

Widget _cardsReview() {
  var lorem =
      "Este es un texto lorem pero para poder dejar una reseña del usuario";
  return Container(
    margin: const EdgeInsets.only(top: 10),
    padding: const EdgeInsets.only(left: 10, right: 10),
    width: 320,
    child: Column(
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: const Image(
                width: 49,
                height: 43,
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1542206395-9feb3edaa68d?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzJ8fHBlcnNvbmF8ZW58MHx8MHx8fDA%3D'),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerText(
                      texto: "Mike Thompson",
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                  headerText(
                      texto: "12 Reseñas",
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: gris),
                ],
              ),
            ),
            const Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 60,
                height: 30,
                color: orange,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    headerText(
                        texto: '4',
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                    const Icon(Icons.star, color: Colors.white, size: 14)
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: headerText(
              texto: lorem,
              color: gris,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.left),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: headerText(
            texto: "Ver toda la reseña",
            color: orange,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    ),
  );
}

Widget _yourRating() {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    padding: const EdgeInsets.only(left: 10, right: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 60,
                height: 30,
                color: orangeOpacity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    headerText(
                        texto: '1',
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                    Icon(Icons.star, color: Colors.white, size: 14)
                  ],
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 60,
                height: 30,
                color: orangeOpacity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    headerText(
                        texto: '2',
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                    const Icon(Icons.star, color: Colors.white, size: 14)
                  ],
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 60,
                height: 30,
                color: orangeOpacity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    headerText(
                        texto: '3',
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                    const Icon(Icons.star, color: Colors.white, size: 14)
                  ],
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 60,
                height: 30,
                color: orange,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    headerText(
                        texto: '4',
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                    const Icon(Icons.star, color: Colors.white, size: 14)
                  ],
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 60,
                height: 30,
                color: orangeOpacity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    headerText(
                        texto: '5',
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                    const Icon(Icons.star, color: Colors.white, size: 14)
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, left: 20),
          child: headerText(
              texto:
                  "Lorem ipsum dolor sit amet consectetur adipiscing elit vulputate volutpat, nisi cubilia pellentesque tincidunt scelerisque primis eu eget, mauris sed nostra penatibus luctus blandit montes sodales. Dictum fermentum quisque natoque eleifend enim vehicula litora cursus, eu mi ligula a vivamus turpis senectus in commodo, massa ante magna diam tortor mollis rhoncus. ",
              color: gris,
              fontWeight: FontWeight.w400,
              fontSize: 12,
              textAlign: TextAlign.left),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, left: 20),
          child: headerText(
            texto: "Editar reseña",
            color: orange,
            fontWeight: FontWeight.w500,
            fontSize: 15.0,
          ),
        )
      ],
    ),
  );
}
