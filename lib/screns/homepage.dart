import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  String _infoText = "Informaçoes dos seu dados:";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFild() {
    pesoController.text = "";
    alturaController.text = "";
    //setState controller de stado
    setState(() {
     _infoText = "Informe seus dados:";
       _formKey = GlobalKey<FormState>();
    });
  }

  void calc() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text("primeiro App"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFild,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image(
                image: AssetImage(
                "img/icon.png",
                ),
                height: 200,
                width: 200,
                ),

              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: " Digite sua Altura(Cm):",
                  labelStyle: TextStyle(fontSize: 20, color: Colors.blueGrey),
                ),
                controller: alturaController,
                validator: (value){
                    if(value.isEmpty){
                        return " Digite sua Altura!";
                    }
                },
              ),

              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Digite seu peso(Kg):",
                  labelStyle: TextStyle(fontSize: 20, color: Colors.blueGrey),
                ),
                controller: pesoController,
                validator:(value){
                    if( value.isEmpty){
                        return "Digite o seu peso!!";
                    }
                },
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed:(){
                      if(_formKey.currentState.validate()){
                        calc();
                      }
                       
                    } ,
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.green,

                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.greenAccent, fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
