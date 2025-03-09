
import 'dart:math';
import 'package:flutter/material.dart';

class CalculatorScreen2 extends StatefulWidget {
  @override
  _CalculatorScreenState2 createState() => _CalculatorScreenState2();
}

class _CalculatorScreenState2 extends State<CalculatorScreen2> {
  TextEditingController kzuController = TextEditingController();

  String Kz1 = "";

  void calculate() {
    double Kzu = double.tryParse(kzuController.text) ?? 0;

    double Uc = 10.5;
    double Kz = Uc / (sqrt(3.0) * (Uc * Uc / Kzu) + ((Uc / 100) * (Uc * Uc / 6.3)));

    setState(() {
      Kz1 = Kz.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Калькулятор 2")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: kzuController,
                decoration: InputDecoration(labelText: "Kzu"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: calculate,
                child: Text("Розрахувати"),
              ),
              SizedBox(height: 20),
              Text("Струм трифазного КЗ: $Kz1")
            ],
          ),
        ),
      ),
    );
  }
}

