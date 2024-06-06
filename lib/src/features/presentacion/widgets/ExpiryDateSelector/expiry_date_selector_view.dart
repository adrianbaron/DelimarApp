import 'package:app_delivery/src/colors/colors.dart';
import 'package:flutter/material.dart';

mixin ExpiryDateSelectorDelegate {
  void onExpiryDateSelected(String expiryDate);
}

class ExpiryDateSelectorView extends StatefulWidget {
  final ExpiryDateSelectorDelegate delegate;

  ExpiryDateSelectorView({required this.delegate});

  @override
  _ExpiryDateSelectorViewState createState() => _ExpiryDateSelectorViewState();
}

class _ExpiryDateSelectorViewState extends State<ExpiryDateSelectorView> {
  int? _selectedMonth;
  int? _selectedYear;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: orange,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Select Expiry Date',
            style: TextStyle(color: Colors.white)),
        actions: [
          GestureDetector(
            onTap: _onSubmit,
            child: Container(
                padding: const EdgeInsets.only(top: 20, right: 15.0),
                child: const Text("Done",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500))),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownButton<int>(
                value: _selectedMonth,
                items: _buildMonthItems(),
                onChanged: _onMonthSelected,
                hint: const Text('Month'),
              ),
              DropdownButton<int>(
                value: _selectedYear,
                items: _buildYearItems(),
                onChanged: _onYearSelected,
                hint: const Text('Year'),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

extension PrivateMethods on _ExpiryDateSelectorViewState {
  void _onMonthSelected(int? month) {
    setState(() {
      _selectedMonth = month;
    });
  }

  void _onYearSelected(int? year) {
    setState(() {
      _selectedYear = year;
    });
  }

  void _onSubmit() {
    if (_selectedMonth != null && _selectedYear != null) {
      String expiryDate =
          "${_selectedMonth.toString().padLeft(2, '0')}/$_selectedYear";
      widget.delegate.onExpiryDateSelected(expiryDate);
      Navigator.of(context).pop();
    }
  }

  List<DropdownMenuItem<int>> _buildMonthItems() {
    return List.generate(12, (index) => index + 1).map((month) {
      return DropdownMenuItem(
        value: month,
        child: Text(month.toString().padLeft(2, '0')),
      );
    }).toList();
  }

  List<DropdownMenuItem<int>> _buildYearItems() {
    int currentYear = DateTime.now().year;
    return List.generate(20, (index) => currentYear + index).map((year) {
      return DropdownMenuItem(
        value: year,
        child: Text(year.toString()),
      );
    }).toList();
  }
}
