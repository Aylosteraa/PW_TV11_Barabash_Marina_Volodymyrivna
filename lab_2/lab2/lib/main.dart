import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(FuelCalculatorApp());
}

class FuelCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel Emission Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FuelCalculatorScreen(),
    );
  }
}

class FuelCalculatorScreen extends StatefulWidget {
  @override
  _FuelCalculatorScreenState createState() => _FuelCalculatorScreenState();
}

class _FuelCalculatorScreenState extends State<FuelCalculatorScreen> {
  final TextEditingController coalController = TextEditingController();
  final TextEditingController masutController = TextEditingController();
  final TextEditingController gasController = TextEditingController();
  
  double gasDensity = 0.273;
  String kCoal = "", eCoal = "", kMasut = "", eMasut = "", kGas = "", eGas = "";
  bool showResult = false;

  void calculateResults() {
    double bCoal = double.tryParse(coalController.text) ?? 0.0;
    double bMasut = double.tryParse(masutController.text) ?? 0.0;
    double bGas = (double.tryParse(gasController.text) ?? 0.0) * gasDensity;

    double kCoalValue = pow(10, 6) / 20.47 * 0.8 * 25.2 / (100 - 1.5) * (1 - 0.985);
    double eCoalValue = pow(10, -6) * kCoalValue * 20.47 * bCoal;
    
    double kMasutValue = pow(10, 6) / 39.48 * 1 * 0.15 / (100 - 0) * (1 - 0.985);
    double eMasutValue = pow(10, -6) * kMasutValue * 39.48 * bMasut;
    
    double kGasValue = pow(10, 6) / 33.08 * 0 * 0 / (100 - 0) * (1 - 0.985);
    double eGasValue = pow(10, -6) * kGasValue * 33.08 * bGas;

    setState(() {
      kCoal = "${kCoalValue.toStringAsFixed(2)} г/ГДж";
      eCoal = "${eCoalValue.toStringAsFixed(2)} т";
      kMasut = "${kMasutValue.toStringAsFixed(2)} г/ГДж";
      eMasut = "${eMasutValue.toStringAsFixed(2)} т";
      kGas = "${kGasValue.toStringAsFixed(2)} г/ГДж";
      eGas = "${eGasValue.toStringAsFixed(2)} т";
      showResult = true;
    });
  }

  void resetForm() {
    setState(() {
      showResult = false;
      coalController.clear();
      masutController.clear();
      gasController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fuel Emission Calculator')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
          TextField(
          controller: coalController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Вугілля (BCoal)'),
        ),
        TextField(
          controller: masutController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Мазут (BMasut)'),
        ),
        TextField(
          controller: gasController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Газ (BGas)'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: calculateResults,
          child: Text('Розрахувати'),
        ),

        SizedBox(height: 20),
            if (showResult) ...[
              Text('Коефіцієнт емісії вугілля: $kCoal'),
        Text('Валовий викид вугілля: $eCoal'),
        Text('Коефіцієнт емісії мазуту: $kMasut'),
        Text('Валовий викид мазуту: $eMasut'),
        Text('Коефіцієнт емісії газ: $kGas'),
        Text('Валовий викид газ: $eGas'),
            ]
        ]

        )
        
        ),
    );
  }
  
}
