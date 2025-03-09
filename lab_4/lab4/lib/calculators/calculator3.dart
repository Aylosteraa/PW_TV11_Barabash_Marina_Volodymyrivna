
import 'dart:math';
import 'package:flutter/material.dart';

class CalculatorScreen3 extends StatefulWidget {
  @override
  _CalculatorScreenState3 createState() => _CalculatorScreenState3();
}

class _CalculatorScreenState3 extends State<CalculatorScreen3> {
  TextEditingController rhController = TextEditingController();
  TextEditingController xhController = TextEditingController();
  TextEditingController rmController = TextEditingController();
  TextEditingController xmController = TextEditingController();
  TextEditingController jEkController = TextEditingController();

  String I3Normal = "";
  String I3Min = "";
  String I2Normal = "";
  String I2Min = "";
  String DI3Normal = "";
  String DI3Min = "";
  String DI2Normal = "";
  String DI2Min = "";

  void calculate() {
    double Rh = double.tryParse(rhController.text) ?? 0;
    double Xh = double.tryParse(xhController.text) ?? 0;
    double Rm = double.tryParse(rmController.text) ?? 0;
    double Xm = double.tryParse(xmController.text) ?? 0;

    double U = 115.0;
    double Ub = 11.0;
    double sqrt3 = sqrt(3.0);
    double multiplier = pow(10, 3).toDouble();

    double Xt = (11.1 * pow(U, 2)) / (100 * 6.3);

    double Z = sqrt(pow(Rh, 2) + pow(Xh + Xt, 2));
    double ZMin = sqrt(pow(Rm, 2) + pow(Xm + Xt, 2));

    double i3Normal = (U * multiplier) / (sqrt3 * Z);
    double i3Min = (U * multiplier) / (sqrt3 * ZMin);

    double i2Normal = i3Normal * (sqrt3 / 2);
    double i2Min = i3Min * (sqrt3 / 2);

    double k = pow(Ub, 2) / pow(U, 2);
    double ZTrue = sqrt(pow(Rh * k, 2) + pow((Xh + Xt) * k, 2));
    double ZMinTrue = sqrt(pow(Rm * k, 2) + pow((Xm + Xt) * k, 2));

    double dI3Normal = (Ub * multiplier) / (sqrt3 * ZTrue);
    double dI3Min = (Ub * multiplier) / (sqrt3 * ZMinTrue);

    double dI2Normal = dI3Normal * (sqrt3 / 2);
    double dI2Min = dI3Min * (sqrt3 / 2);

    setState(() {
      I3Normal = i3Normal.toStringAsFixed(2);
      I3Min = i3Min.toStringAsFixed(2);

      I2Normal = i2Normal.toStringAsFixed(2);
      I2Min = i2Min.toStringAsFixed(2);

      DI3Normal = dI3Normal.toStringAsFixed(2);
      DI3Min = dI3Min.toStringAsFixed(2);

      DI2Normal = dI2Normal.toStringAsFixed(2);
      DI2Min = dI2Min.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Калькулятор 3")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: rhController,
                decoration: InputDecoration(labelText: "Rh"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: xhController,
                decoration: InputDecoration(labelText: "Xh"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: rmController,
                decoration: InputDecoration(labelText: "Rm"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: xmController,
                decoration: InputDecoration(labelText: "Xm"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: calculate,
                child: Text("Розрахувати"),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft, // Вирівнювання тексту по лівому краю
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Вирівнювання тексту в Column
                  children: [
                    Text(
                      "Струм трифазного КЗ",
                      style: TextStyle(fontWeight: FontWeight.bold), // Жирний текст
                    ),
                    Text("Нормальний режим: $I3Normal"),
                    Text("Мінімальний режим: $I3Min"),

                    Text(
                      "Струм двофазного КЗ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("Нормальний режим: $I2Normal"),
                    Text("Мінімальний режим: $I2Min"),

                    Text(
                      "Дійсний струм трифазного КЗ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("Нормальний режим: $DI3Normal"),
                    Text("Мінімальний режим: $DI3Min"),

                    Text(
                      "Дійсний струм двофазного КЗ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("Нормальний режим: $DI2Normal"),
                    Text("Мінімальний режим: $DI2Min"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

