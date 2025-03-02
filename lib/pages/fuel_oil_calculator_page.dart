import 'package:flutter/material.dart';
import '../services/calculations.dart';

class FuelOilCalculatorPage extends StatefulWidget {
  @override
  _FuelOilCalculatorPageState createState() => _FuelOilCalculatorPageState();
}

class _FuelOilCalculatorPageState extends State<FuelOilCalculatorPage> {
  final TextEditingController carbonController = TextEditingController(text: "85.5");
  final TextEditingController hydrogenController = TextEditingController(text: "11.2");
  final TextEditingController oxygenController = TextEditingController(text: "0.8");
  final TextEditingController sulfurController = TextEditingController(text: "2.5");
  final TextEditingController lowerHeatController = TextEditingController(text: "40.4");
  final TextEditingController moistureController = TextEditingController(text: "2");
  final TextEditingController ashController = TextEditingController(text: "0.15");
  final TextEditingController vanadiumController = TextEditingController(text: "333.3");

  Map<String, dynamic>? result;

  void _calculateFuelOil() {
    final double carbon = double.tryParse(carbonController.text) ?? 0.0;
    final double hydrogen = double.tryParse(hydrogenController.text) ?? 0.0;
    final double oxygen = double.tryParse(oxygenController.text) ?? 0.0;
    final double sulfur = double.tryParse(sulfurController.text) ?? 0.0;
    final double lowerHeat = double.tryParse(lowerHeatController.text) ?? 0.0;
    final double moisture = double.tryParse(moistureController.text) ?? 0.0;
    final double ash = double.tryParse(ashController.text) ?? 0.0;
    final double vanadium = double.tryParse(vanadiumController.text) ?? 0.0;

    setState(() {
      result = recalculateFuelOilComposition(
          carbon, hydrogen, oxygen, sulfur, lowerHeat, moisture, ash, vanadium);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Введіть параметри палива:"),
          TextField(
            controller: carbonController,
            decoration: InputDecoration(labelText: "Вуглець (C)"),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: hydrogenController,
            decoration: InputDecoration(labelText: "Водень (H)"),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: oxygenController,
            decoration: InputDecoration(labelText: "Кисень (O)"),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: sulfurController,
            decoration: InputDecoration(labelText: "Сірка (S)"),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: lowerHeatController,
            decoration: InputDecoration(labelText: "Нижня теплота згоряння (Q)"),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: moistureController,
            decoration: InputDecoration(labelText: "Вологість (W)"),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: ashController,
            decoration: InputDecoration(labelText: "Зольність (A)"),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: vanadiumController,
            decoration: InputDecoration(labelText: "Вміст ванадію (V)"),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _calculateFuelOil,
            child: Text("Розрахувати"),
          ),
          SizedBox(height: 16),
          if (result != null) ...[
            Text("Склад робочої маси мазуту складатиме:"),
            Text("  - Вуглець (C): ${(result!["C"] as double).toStringAsFixed(2)} %"),
            Text("  - Водень (H): ${(result!["H"] as double).toStringAsFixed(2)} %"),
            Text("  - Кисень (O): ${(result!["O"] as double).toStringAsFixed(2)} %"),
            Text("  - Сірка (S): ${(result!["S"] as double).toStringAsFixed(2)} %"),
            Text("  - Зола (A): ${(result!["A"] as double).toStringAsFixed(2)} %"),
            Text("  - Ванадій (V): ${(result!["V"] as double).toStringAsFixed(2)} мг/кг"),
            Text("  - Нижча теплота згоряння: ${(result!["LowerHeatWorking"] as double).toStringAsFixed(2)} МДж/кг"),
          ]
        ],
      ),
    );
  }
}
