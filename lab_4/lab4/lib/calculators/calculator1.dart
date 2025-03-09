
import 'dart:math';
import 'package:flutter/material.dart';

class CalculatorScreen1 extends StatefulWidget {
  @override
  _CalculatorScreenState1 createState() => _CalculatorScreenState1();
}

class _CalculatorScreenState1 extends State<CalculatorScreen1> {
  TextEditingController uController = TextEditingController();
  TextEditingController iController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController smController = TextEditingController();
  TextEditingController jEkController = TextEditingController();

  String bronC = "";
  String aabC = "";

  void calculate() {
    double U = double.tryParse(uController.text) ?? 0;
    double I = double.tryParse(iController.text) ?? 0;
    double time = double.tryParse(timeController.text) ?? 0;
    double sm = double.tryParse(smController.text) ?? 0;
    double jEk = double.tryParse(jEkController.text) ?? 0;

    double im = sm / (2 * sqrt(3.0) * U);
    double bron = im / jEk;
    double aab = I * sqrt(time) / 92.0;

    setState(() {
      bronC = bron.toStringAsFixed(2);
      aabC = aab.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Калькулятор 1")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: uController,
                decoration: InputDecoration(labelText: "U"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: iController,
                decoration: InputDecoration(labelText: "I"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: timeController,
                decoration: InputDecoration(labelText: "Time"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: smController,
                decoration: InputDecoration(labelText: "Sm"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: jEkController,
                decoration: InputDecoration(labelText: "JEk"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: calculate,
                child: Text("Розрахувати"),
              ),
              SizedBox(height: 20),
              Text("Броньований кабель: $bronC"),
              Text("ААБ кабель: $aabC"),
            ],
          ),
        ),
      ),
    );
  }
}

