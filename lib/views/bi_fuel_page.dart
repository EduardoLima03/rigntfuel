import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import '../utils/app_localizations.dart';

class BiFuelPage extends StatefulWidget {
  @override
  _BiFuelPageState createState() => _BiFuelPageState();
}

class _BiFuelPageState extends State<BiFuelPage> {
  String _mensg = "";
  double _continuousValue = 70;

  final _controllerEtanol =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  final _controllerGasolina =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');

  void calculo() {
    double porcentegem = _continuousValue / 100;
    double gasolina = double.parse(_controllerGasolina.text);
    double etanol = double.parse(_controllerEtanol.text);
    /**
     * TODO erro 0
     * 
     * esta entendo a realizão do calculo quando nada é digital, na verdade os 
     * campos tem velor pela mascara que inicia com o valor 0.00. o programa
     * não pode acontecer isso. Resolver no proximo comint ou branch
     */

    if ((etanol / gasolina) <= porcentegem) {
      setState(() {
        _mensg = AppLocalizations.of(context).translate('smt_ethanol');
      });
    } else {
      setState(() {
        _mensg = AppLocalizations.of(context).translate('smt_gasoline');
      });
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
                      AppLocalizations.of(context).translate('help_bifuel'),
                    ),
                    Text(
                      AppLocalizations.of(context).translate('help_bifuel2'),
                    ),
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
        title: Text(AppLocalizations.of(context).translate('bifuel')),
        actions: [IconButton(icon: Icon(Icons.help), onPressed: _showMyDialog)],
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 16.0,
              ),
              Text(
                AppLocalizations.of(context).translate('coefficient'),
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              Column(
                children: [
                  SizedBox(
                    width: 64,
                    height: 48,
                    child: TextField(
                      textAlign: TextAlign.center,
                      onSubmitted: (value) {
                        //salvando o valor digitado na variavel
                        final double newValue = double.tryParse(value);
                        if (newValue != null && newValue != _continuousValue) {
                          setState(() {
                            _continuousValue = newValue.clamp(0, 100) as double;
                          });
                        }
                      },
                      keyboardType: TextInputType.number,
                      controller: TextEditingController(
                        text: _continuousValue.toStringAsFixed(0),
                      ),
                    ),
                  ),
                  Slider(
                    value: _continuousValue,
                    onChanged: (value) {
                      setState(() {
                        _continuousValue = value;
                      });
                    },
                    min: 0,
                    max: 100,
                  ),
                ],
              ),
              TextField(
                decoration: InputDecoration(
                  labelText:
                      AppLocalizations.of(context).translate('tax_ethanol'),
                  labelStyle: TextStyle(
                    color: Theme.of(context).accentColor,
                  ),
                  prefixText: "R\$ ",
                ),
                keyboardType: TextInputType.numberWithOptions(),
                controller: _controllerEtanol,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText:
                      AppLocalizations.of(context).translate('tax_gasoline'),
                  labelStyle: TextStyle(color: Theme.of(context).accentColor),
                  prefixText: "R\$ ",
                ),
                keyboardType: TextInputType.numberWithOptions(),
                controller: _controllerGasolina,
              ),
              SizedBox(
                height: 24,
              ),
              RaisedButton(
                onPressed: calculo,
                child: Text(
                  AppLocalizations.of(context).translate('calculate'),
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).accentColor,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                _mensg,
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
