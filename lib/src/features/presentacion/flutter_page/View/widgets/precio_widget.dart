import 'package:app_delivery/src/colors/colors.dart';
import 'package:flutter/material.dart';

class PrecioFilter extends StatefulWidget {
  @override
  State<PrecioFilter> createState() => _PrecioFilterState();
}

class _PrecioFilterState extends State<PrecioFilter> {
  RangeValues _values = RangeValues(0.3, 1.0);
  int _minPrecio = 0;
  int _maxPrecio = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(' $_minPrecio COP', style: TextStyle(fontSize: 16)),
        Container(
          width: 240,
          child: RangeSlider(
            activeColor: orange,
            inactiveColor: gris,
            values: _values,
            min: 0,
            max: 100.0,
            onChanged: (RangeValues newValues) {
              setState(() {
                _values = newValues;
                _minPrecio = _values.start.round();
                _maxPrecio = _values.end.round();
              });
            },
          ),
        ),
        Text('$_maxPrecio COP', style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
