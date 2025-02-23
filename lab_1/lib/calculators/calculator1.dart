
import 'package:flutter/material.dart';

class CalculatorScreen1 extends StatefulWidget {
  @override
  _CalculatorScreenState1 createState() => _CalculatorScreenState1();
}

class _CalculatorScreenState1 extends State<CalculatorScreen1> {
  final TextEditingController carbonController = TextEditingController();
  final TextEditingController hydrogenController = TextEditingController();
  final TextEditingController oxygenController = TextEditingController();
  final TextEditingController sulfurController = TextEditingController();
  final TextEditingController ashController = TextEditingController();
  final TextEditingController moistureController = TextEditingController();

  double coefficientWtoD = 0.0;
  double coefficientWtoC = 0.0;
  double heatWorkingMass = 0.0;
  double heatDryMass = 0.0;
  double heatCombustibleMass = 0.0;
  bool calculated = false;

  void calculate() {
    setState(() {
      double carbon = double.tryParse(carbonController.text) ?? 0.0;
      double hydrogen = double.tryParse(hydrogenController.text) ?? 0.0;
      double oxygen = double.tryParse(oxygenController.text) ?? 0.0;
      double sulfur = double.tryParse(sulfurController.text) ?? 0.0;
      double ash = double.tryParse(ashController.text) ?? 0.0;
      double moisture = double.tryParse(moistureController.text) ?? 0.0;

      coefficientWtoD = 100 / (100 - moisture);
      coefficientWtoC = 100 / (100 - moisture - ash);

      heatWorkingMass =
          (339 * carbon + 1030 * hydrogen - 108.8 * (oxygen - sulfur) - 25 * moisture) / 1000;
      heatDryMass = (heatWorkingMass + 0.025 * moisture) * 100 / (100 - moisture);
      heatCombustibleMass = (heatWorkingMass + 0.025 * moisture) * 100 / (100 - moisture - ash);
      calculated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Калькулятор')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: carbonController, decoration: InputDecoration(labelText: 'Вуглець')),
            TextField(controller: hydrogenController, decoration: InputDecoration(labelText: 'Водень')),
            TextField(controller: oxygenController, decoration: InputDecoration(labelText: 'Кисень')),
            TextField(controller: sulfurController, decoration: InputDecoration(labelText: 'Сірка')),
            TextField(controller: ashController, decoration: InputDecoration(labelText: 'Вміст золи в паливі')),
            TextField(controller: moistureController, decoration: InputDecoration(labelText: 'Вміст вологи в паливі')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: calculate, child: Text('Обчислити')),
            SizedBox(height: 20),
            if (calculated) ...[
              Text('Коеф. W to D: $coefficientWtoD'),
              Text('Коеф. W to C: $coefficientWtoC'),
              Text('Теплота робочої маси: $heatWorkingMass'),
              Text('Теплота сухої маси: $heatDryMass'),
              Text('Теплота горючої маси: $heatCombustibleMass'),
            ]
          ],
        ),
      ),
    );
  }
}
