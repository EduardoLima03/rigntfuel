import 'package:flutter/material.dart';

import '../../app_localizations.dart';

class ConsumoMedioActivity extends StatefulWidget {
  @override
  _ConsumoMedioActivityState createState() => _ConsumoMedioActivityState();
}

class _ConsumoMedioActivityState extends State<ConsumoMedioActivity> {
  //objetos que recupera o valor do campos
  final TextEditingController firstnumber = TextEditingController();
  final TextEditingController secongtnumber = TextEditingController();
  final TextEditingController fuel = TextEditingController();
  final km = TextEditingController();

  //variaveis
  int number, number2;
  var number3;
  var mensag = "";
  //essa variavel é para muda o status do enabled no TextField,

//calculo de km rodado, retorna o valor
  int _mileageCalculation() {
    number =
        int.parse(firstnumber.text); //convertendo o String para valor inteiro
    number2 = int.parse(secongtnumber.text);

    if(firstnumber.text.length <= 3){
      return int.parse(firstnumber.text);
    }else{
      return number2 - number;
    }
  }

  //calculor de consumo medio
  void _calculationConsumption() {
    number3 = double.parse(fuel.text);
    var calc = (_mileageCalculation() / number3)
        .toStringAsFixed(2); //converte o calculo para string
    setState(() {
      mensag = calc + " Km/l";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('consumption')),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 24,
              ),
              TextFormField(
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).translate('odometer_1'),
                  hintText: AppLocalizations.of(context).translate('hint_text_1'),
                ),
                //enabled: _textEneabled,//uso uma variavel para saber a nosso brincadeira
                enabled: km.value.text.isEmpty,
                keyboardType: TextInputType.number,
                controller: firstnumber,
                maxLength: 6,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).translate('odometer_2'),
                    hintText: AppLocalizations.of(context).translate('hint_text_2')),
                keyboardType: TextInputType.number,
                controller: secongtnumber,
                maxLength: 6,
                enabled: km.value.text.length > 0 && km.value.text.length <= 3 ? false : true,
              ),
              //km
              SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).translate("fuel"),
                  hintText:
                      AppLocalizations.of(context).translate('hint_text_3'),
                ),
                controller: fuel,
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: RaisedButton(
                  onPressed: _calculationConsumption,
                  child: Text(
                    AppLocalizations.of(context).translate('calculate'),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Theme.of(context).accentColor,
                ),
              ),
              Text(mensag),
            ],
          ),
        ),
      ),
    );
  }
}
