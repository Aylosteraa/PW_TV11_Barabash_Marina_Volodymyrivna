import 'package:flutter/material.dart';

class CalculatorScreen2 extends StatefulWidget {
  @override
  _CalculatorScreenState2 createState() => _CalculatorScreenState2();
}

class _CalculatorScreenState2 extends State<CalculatorScreen2> {
  final TextEditingController carbonController = TextEditingController();
  final TextEditingController hydrogenController = TextEditingController();
  final TextEditingController oxygenController = TextEditingController();
  final TextEditingController sulfurController = TextEditingController();
  final TextEditingController oilHeatController = TextEditingController();
  final TextEditingController fuelMoistureController = TextEditingController();
  final TextEditingController ashController = TextEditingController();
  final TextEditingController vanadiumController = TextEditingController();

  double carbonWM = 0.0;
  double hydrogenWM = 0.0;
  double oxygenWM = 0.0;
  double sulfurWM = 0.0;
  double ashWM = 0.0;
  double vanadiumWM = 0.0;
  double lowerHeatResult = 0.0;
  bool calculated = false;

  void calculate() {
    setState(() {
      double carbon = double.tryParse(carbonController.text) ?? 0.0;
      double hydrogen = double.tryParse(hydrogenController.text) ?? 0.0;
      double oxygen = double.tryParse(oxygenController.text) ?? 0.0;
      double sulfur = double.tryParse(sulfurController.text) ?? 0.0;
      double oilHeat = double.tryParse(oilHeatController.text) ?? 0.0;
      double fuelMoisture = double.tryParse(fuelMoistureController.text) ?? 0.0;
      double ash = double.tryParse(ashController.text) ?? 0.0;
      double vanadium = double.tryParse(vanadiumController.text) ?? 0.0;

      double factor1 = (100 - fuelMoisture - ash) / 100;
      double factor2 = (100 - fuelMoisture / 10 - ash / 10) / 100;
      double factor3 = (100 - fuelMoisture) / 100;

      carbonWM = carbon * factor1;
      hydrogenWM = hydrogen * factor1;
      oxygenWM = oxygen * factor2;
      sulfurWM = sulfur * factor1;
      ashWM = ash * factor3;
      vanadiumWM = vanadium * factor3;
      lowerHeatResult = oilHeat * factor1 - 0.025 * fuelMoisture;

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
            TextField(controller: oilHeatController, decoration: InputDecoration(labelText: 'Нижча теплота згорання горючої маси мазути')),
            TextField(controller: fuelMoistureController, decoration: InputDecoration(labelText: 'Вміст вологи в паливі')),
            TextField(controller: ashController, decoration: InputDecoration(labelText: 'Вміст золи в паливі')),
            TextField(controller: vanadiumController, decoration: InputDecoration(labelText: 'Ванадій')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: calculate, child: Text('Обчислити')),
            SizedBox(height: 20),
            if (calculated) ...[
              Text('Склад робочої маси мазуту'),
              Text('Вуглець: $carbonWM'),
              Text('Водень: $hydrogenWM'),
              Text('Кисень: $oxygenWM'),
              Text('Сірка: $sulfurWM'),
              Text('Вміст золи в паливі: $ashWM'),
              Text('Ванадій: $vanadiumWM'),
              Text('Нижча теплота згорання: $lowerHeatResult'),
            ]
          ],
        ),
      ),
    );
  }
}
