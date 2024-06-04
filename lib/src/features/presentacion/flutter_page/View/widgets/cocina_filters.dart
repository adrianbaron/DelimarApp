import 'package:flutter/material.dart';

class CocinaFilters extends StatefulWidget {
  const CocinaFilters({super.key});

  @override
  State<CocinaFilters> createState() => _CocinaFiltersState();
}

class _CocinaFiltersState extends State<CocinaFilters> {
  bool btnAmerica = false;
  bool btnSushi = false;
  bool btnAsia = false;
  bool btnPizza = false;

  bool btnDesserts = false;
  bool btnFastFood = false;
  bool btnVietnase = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _roundedButtonFilter(() {
              setState(() {
                btnAmerica = !btnAmerica;
              });
            }, btnAmerica, 'Americana'),
            _roundedButtonFilter(() {
              setState(() {
                btnAsia = !btnAsia;
              });
            }, btnAsia, 'Asiatica'),
            _roundedButtonFilter(() {
              setState(() {
                btnPizza = !btnPizza;
              });
            }, btnPizza, 'Pizzas'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _roundedButtonFilter(() {
              setState(() {
                btnAmerica = !btnAmerica;
              });
            }, btnAmerica, 'Americana'),
            _roundedButtonFilter(() {
              setState(() {
                btnAsia = !btnAsia;
              });
            }, btnAsia, 'Asiatica'),
            _roundedButtonFilter(() {
              setState(() {
                btnPizza = !btnPizza;
              });
            }, btnPizza, 'Pizzas'),
          ],
        )
      ],
    );
  }
}

Widget _roundedButtonFilter(
    VoidCallback func, bool isActive, String labelText) {
  return ElevatedButton(
    onPressed: func,
    style: ElevatedButton.styleFrom(
      elevation: 0.5,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: BorderSide(color: isActive ? Colors.orange : Colors.grey),
      ),
    ),
    child: Text(
      labelText,
      style: TextStyle(
        color: isActive ? Colors.orange : Colors.grey,
      ),
    ),
  );
}
