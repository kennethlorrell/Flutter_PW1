import 'package:flutter/material.dart';
import 'fuel_calculator_page.dart';
import 'fuel_oil_calculator_page.dart';

enum CalculatorType { fuel, fuelOil }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalculatorType _selectedCalculator = CalculatorType.fuel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedCalculator == CalculatorType.fuel
            ? "Завдання 1"
            : "Завдання 2"),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _selectedCalculator = CalculatorType.fuel;
              });
            },
            child: Text(
              "Завдання 1",
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _selectedCalculator = CalculatorType.fuelOil;
              });
            },
            child: Text(
              "Завдання 2",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _selectedCalculator == CalculatorType.fuel
            ? FuelCalculatorPage()
            : FuelOilCalculatorPage(),
      ),
    );
  }
}
