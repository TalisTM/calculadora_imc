import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main(){
  runApp(
    MaterialApp(
      home: Home(),
    )
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weigthController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _infoText = "Informe seus dados!";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields(){
    weigthController.text = "";
    heightController.text = "";

    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate(){
    setState(() {
      double weigth = double.parse(weigthController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weigth / (height * height);

      if(imc < 18.6){
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 18.6 && imc < 24.9){
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 24.9 && imc < 29.9){
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 29.9 && imc < 34.9){
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 34.9 && imc < 39.9){
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 40){
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (KG)",
                    labelStyle: TextStyle(
                      color: Colors.green,
                    )
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 25
                ),
                controller: weigthController,
                validator: (value) {
                  if(value.isEmpty){
                    return "Insira seu peso!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (CM)",
                    labelStyle: TextStyle(
                      color: Colors.green,
                    )
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 25
                ),
                controller: heightController,
                validator: (value) {
                  if(value.isEmpty){
                    return "Insira sua Altura!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  height: 50,
                  child: RaisedButton(
                    child: Text(
                      "Calcular",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25
                      ),
                    ),
                    color: Colors.green,
                    onPressed: (){
                      if(_formKey.currentState.validate()){
                        _calculate();
                      }
                    },
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 25
                ),
              )
            ],
          ),
        )
      )
    );
  }
}
