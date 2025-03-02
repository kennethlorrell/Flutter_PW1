import 'package:flutter/material.dart';
import '../models/fuel_composition_result.dart';
import '../services/calculations.dart';

class FuelCalculatorPage extends StatefulWidget {
  @override
  _FuelCalculatorPageState createState() => _FuelCalculatorPageState();
}

class _FuelCalculatorPageState extends State<FuelCalculatorPage> {
  final TextEditingController hydrogenController = TextEditingController(text: "1.4");
  final TextEditingController carbonController = TextEditingController(text: "70.5");
  final TextEditingController sulfurController = TextEditingController(text: "1.7");
  final TextEditingController nitrogenController = TextEditingController(text: "0.8");
  final TextEditingController oxygenController = TextEditingController(text: "1.9");
  final TextEditingController moistureController = TextEditingController(text: "7");
  final TextEditingController ashController = TextEditingController(text: "16.7");

  FuelCompositionResult? result;

  void _calculateFuelProperties() {
    final double hydrogen = double.tryParse(hydrogenController.text) ?? 0.0;
    final double carbon = double.tryParse(carbonController.text) ?? 0.0;
    final double sulfur = double.tryParse(sulfurController.text) ?? 0.0;
    final double nitrogen = double.tryParse(nitrogenController.text) ?? 0.0;
    final double oxygen = double.tryParse(oxygenController.text) ?? 0.0;
    final double moisture = double.tryParse(moistureController.text) ?? 0.0;
    final double ash = double.tryParse(ashController.text) ?? 0.0;

    setState(() {
      result = calculateFuelProperties(
          hydrogen, carbon, sulfur, nitrogen, oxygen, moisture, ash);
    });
  }

  String formatMap(Map<String, double> map) {
    return map.entries
        .map((entry) => "${entry.key}: ${entry.value.toStringAsFixed(2)}")
        .join(", ");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Введіть значення компонентів палива:"),
          TextField(
            controller: hydrogenController,
            decoration: InputDecoration(labelText: "Водень (H)"),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: carbonController,
            decoration: InputDecoration(labelText: "Вуглець (C)"),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: sulfurController,
            decoration: InputDecoration(labelText: "Сірка (S)"),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: nitrogenController,
            decoration: InputDecoration(labelText: "Азот (N)"),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: oxygenController,
            decoration: InputDecoration(labelText: "Кисень (O)"),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: moistureController,
            decoration: InputDecoration(labelText: "Волога (W)"),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: ashController,
            decoration: InputDecoration(labelText: "Зола (A)"),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _calculateFuelProperties,
            child: Text("Розрахувати"),
          ),
          SizedBox(height: 16),
          if (result != null) ...[
            Text("Для палива з компонентним складом: ${formatMap(result!.workingMassComposition)}"),
            Text("Коефіцієнт переходу від робочої до сухої маси: ${result!.dryMassCoefficient.toStringAsFixed(2)}"),
            Text("Коефіцієнт переходу від робочої до горючої маси: ${result!.combustibleMassCoefficient.toStringAsFixed(2)}"),
            Text("Склад сухої маси палива: ${formatMap(result!.dryMassComposition)}"),
            Text("Склад горючої маси палива: ${formatMap(result!.combustibleMassComposition)}"),
            Text("Нижня теплота згоряння для робочої маси: ${result!.lowerHeatWorking.toStringAsFixed(2)} МДж/кг"),
            Text("Нижня теплота згоряння для сухої маси: ${result!.lowerHeatDry.toStringAsFixed(2)} МДж/кг"),
            Text("Нижня теплота згоряння для горючої маси: ${result!.lowerHeatCombustible.toStringAsFixed(2)} МДж/кг"),
          ]
        ],
      ),
    );
  }
}
