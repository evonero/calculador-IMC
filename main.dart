import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _infoTexto = "Informe seus dados";

  void _resetFields() {
    weightController.text = '';
    heightController.text = '';
    setState(() => _infoTexto = 'Informe seus dados');
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _infoTexto = "Abaixo do Peso. Seu IMC = ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 18.6 && imc <= 24.9) {
        _infoTexto = "Peso Ideal. Seu IMC = ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 25.0 && imc <= 29.9) {
        _infoTexto =
            "levemente acima do peso. Seu IMC = ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 30.0 && imc <= 34.9) {
        _infoTexto =
            "Obesidade grau I. Seu IMC = ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 35.0 && imc <= 39.9) {
        _infoTexto =
            "Obesidade grau II. Seu IMC = ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 40.0) {
        _infoTexto =
            "Obesidade grau III. Seu IMC = ${imc.toStringAsPrecision(4)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh), onPressed: () => _resetFields())
          ],
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person_outline,
                    size: 170.0,
                    color: Colors.green,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Peso(kg)",
                      labelStyle: TextStyle(
                        color: Colors.green,
                        fontSize: 20.0,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Informe seu Peso!";
                      }
                    },
                    controller: weightController,
                  ),
                  Divider(),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Altura(cm)",
                      labelStyle: TextStyle(
                        color: Colors.green,
                        fontSize: 20.0,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Informe sua Altura!";
                      }
                    },
                    controller: heightController,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        child: Text(
                          "Calcular",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                          ),
                        ),
                        onPressed: () => {
                          if (_formKey.currentState.validate()) {_calculate()},
                        },
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      _infoTexto,
                      style: TextStyle(color: Colors.green, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )));
  }
}
