import 'package:app_delivery/src/colors/colors.dart';
import 'package:app_delivery/src/features/presentacion/tabs/myOrderTab/view/components/empy_view.dart';
import 'package:app_delivery/src/features/presentacion/widgets/Headers/header_text.dart';
import 'package:flutter/material.dart';

class MyOrderTab extends StatefulWidget {
  const MyOrderTab({super.key});

  @override
  State<MyOrderTab> createState() => _MyOrderTabState();
}

class _MyOrderTabState extends State<MyOrderTab> {
  final empyOrderEstate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGrey,
      body: empyOrderEstate
          ? EmpyView()
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  elevation: 0.5,
                  leading: const Text(""),
                  backgroundColor: Colors.white,
                  title: headerText(
                      texto: "Mi pedido",
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 17),
                  centerTitle: true,
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          _orders(context),
                          const SizedBox(height: 20),
                          _checkResume(context)
                        ],
                      ),
                    )
                  ]),
                )
              ],
            ),
    );
  }
}

Widget _orders(BuildContext context) {
  return Column(
    children: [_cardOrder(context)],
  );
}

Widget _cardOrder(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(248, 248, 248, 1.0),
        boxShadow: const [
          BoxShadow(
              color: Color.fromRGBO(210, 211, 215, 1.0),
              spreadRadius: 1.0,
              blurRadius: 4.0)
        ]),
    child: Column(
      children: [
        Row(
          children: [_cardOrderTop()],
        ),
        Column(
          children: [
            _items(context),
            _items(context),
            _items(context),
            _items(context)
          ],
        ),
        _moreContent(context)
      ],
    ),
  );
}

Widget _cardOrderTop() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 7.0, bottom: 7.0, right: 20.0),
          child: headerText(
              texto: "Cola de langosta asada - Delimar",
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.location_on,
              color: gris,
              size: 16,
            ),
            headerText(
                texto: "Calle 4#10-34",
                color: gris,
                fontWeight: FontWeight.w500,
                fontSize: 13.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              width: 110.0,
              height: 20.0,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0.5,
                  shape: const StadiumBorder(),
                  backgroundColor: Colors.orange,
                ),
                child: headerText(
                  texto: "Domicilio gratis",
                  fontSize: 11.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _items(BuildContext context) {
  return Container(
    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: gris))),
    child: ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerText(
              texto: "Especial de chipi chipi",
              color: orange,
              fontWeight: FontWeight.w300,
              fontSize: 15),
          headerText(
              texto: "Mix vegetales, con mejillona",
              color: gris,
              fontWeight: FontWeight.w300,
              fontSize: 12)
        ],
      ),
      trailing: headerText(
          texto: "24.000",
          color: gris,
          fontWeight: FontWeight.w300,
          fontSize: 15),
    ),
  );
}

Widget _moreContent(BuildContext context) {
  return ListTile(
    title: headerText(
        texto: "Añade mas a tu pedido",
        color: rosa,
        fontWeight: FontWeight.w600,
        fontSize: 17),
  );
}

Widget _checkResume(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.symmetric(vertical: 10),
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
              color: Color.fromRGBO(210, 211, 215, 1.0),
              spreadRadius: 1.0,
              blurRadius: 4.0)
        ]),
    child: Column(
      children: [
        _itemsCheckResume(title: "Subtotal", value: '12.000', context: context),
        _itemsCheckResume(title: "Adicionales", value: '0', context: context),
        _itemsCheckResume(
            title: "Domicilio", value: 'Gratis', context: context),
        _bottonCheck(context)
      ],
    ),
  );
}

Widget _itemsCheckResume(
    {title = String, value = String, context = BuildContext}) {
  return Container(
    decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black))),
    child: ListTile(
      title:
          headerText(texto: title, fontWeight: FontWeight.w400, fontSize: 15.0),
      trailing:
          headerText(texto: value, fontWeight: FontWeight.w500, fontSize: 15.0),
    ),
  );
}

Widget _bottonCheck(BuildContext context) {
  return Container(
    width: double.infinity,
    height: 45.0,
    margin: const EdgeInsets.only(top: 10.0),
    child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          elevation: 0.5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.orange,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Container(
              margin: const EdgeInsets.only(left: 50),
              child: headerText(
                texto: "Pedir",
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
                color: Colors.white,
              ),
            ),
            Container(
              child: headerText(
                texto: "12.000",
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                color: Colors.white,
              ),
            )
          ],
        )),
  );
}
