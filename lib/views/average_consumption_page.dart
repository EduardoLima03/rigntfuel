import 'package:flutter/material.dart';
import 'package:rigntfuel/utils/app_localizations.dart';

class AverageConsumptionPage extends StatefulWidget {
  @override
  _AverageConsumptionPageState createState() => _AverageConsumptionPageState();
}

class _AverageConsumptionPageState extends State<AverageConsumptionPage> {
  final _formKay = GlobalKey<FormState>();
  final _initialOdometer = TextEditingController();
  final _finalOdometer = TextEditingController();
  final _fuel = TextEditingController();

  String _mensag = '';

  bool _enableValidator = true;

  //calculor para definir o consumo
  void _calculationConsumption() {
    /** Esse teste consiste em saber se o cmapo esta validade, se nao tiver,
     *  não realiza o calculo */
    if (_formKay.currentState.validate()) {
      /* Teste para saber se o primeiro campo tem de 1 ate 3 digitos. se for esse
      * valor sera o km rodados. se não é feito o calculo do km rodado
      */
      if (_initialOdometer.text.length > 0 &&
          _initialOdometer.text.length <= 3) {
        setState(() {
          _mensag =
              (int.parse(_initialOdometer.text) / double.parse(_fuel.text))
                      .toStringAsFixed(2) +
                  'km/l';
        });
      } else {
        setState(() {
          _mensag = ((int.parse(_finalOdometer.text) -
                          int.parse(_initialOdometer.text)) /
                      double.parse(_fuel.text))
                  .toStringAsFixed(2) +
              'km/l';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context).translate('help_title')),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(
                      AppLocalizations.of(context).translate('odometer_1'),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(AppLocalizations.of(context)
                        .translate('help_odometer_1')),
                    Text(
                      AppLocalizations.of(context).translate('odometer_2'),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(AppLocalizations.of(context)
                        .translate('help_odometer_2')),
                    Text(
                      AppLocalizations.of(context).translate('fuel'),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(AppLocalizations.of(context).translate('help_fuel')),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('consumption')),
        actions: [IconButton(icon: Icon(Icons.help), onPressed: _showMyDialog)],
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKay,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 24,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  controller: _initialOdometer,
                  decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context).translate('odometer_1'),
                    hintText:
                        AppLocalizations.of(context).translate('hint_text_1'),
                  ),
                  validator: (value) => value.isEmpty
                      ? AppLocalizations.of(context).translate('validation')
                      : null,
                  onChanged: (value) {
                    setState(() {
                      _enableValidator = _initialOdometer.text.length > 0 &&
                              _initialOdometer.text.length <= 3
                          ? false
                          : true;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  enabled: _enableValidator,
                  controller: _finalOdometer,
                  decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context).translate('odometer_2'),
                    hintText:
                        AppLocalizations.of(context).translate('hint_text_2'),
                  ),
                  validator: (value) {
                    if (_enableValidator == true) {
                      if (int.parse((_finalOdometer.text)) <=
                          int.parse(_initialOdometer.text)) {
                        return AppLocalizations.of(context)
                            .translate('validation_2');
                      } else {
                        return null;
                      }
                      //return AppLocalizations.of(context).translate('validation');
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _fuel,
                  validator: (value) => value.isEmpty
                      ? AppLocalizations.of(context).translate('validation')
                      : null,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).translate('fuel'),
                    hintText:
                        AppLocalizations.of(context).translate('hint_text_3'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    child: Text(
                      AppLocalizations.of(context).translate('calculate'),
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: _calculationConsumption),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context).translate('msg'),
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      _mensag,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
