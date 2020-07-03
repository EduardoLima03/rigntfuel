import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import '../app_localizations.dart';

class BiFuelPage extends StatefulWidget {
  @override
  _BiFuelPageState createState() => _BiFuelPageState();

  double _continuousValue = 70;
}

class _BiFuelPageState extends State<BiFuelPage> {
  String _mensg = "";

  final _controllerEtanol =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  final _controllerGasolina =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');

  void calculo() {
    double porcentegem = widget._continuousValue / 100;
    double gasolina = double.parse(_controllerGasolina.text);
    double etanol = double.parse(_controllerEtanol.text);

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
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('bifuel')),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
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
                        if (newValue != null &&
                            newValue != widget._continuousValue) {
                          setState(() {
                            widget._continuousValue =
                                newValue.clamp(0, 100) as double;
                          });
                        }
                      },
                      keyboardType: TextInputType.number,
                      controller: TextEditingController(
                        text: widget._continuousValue.toStringAsFixed(0),
                      ),
                    ),
                  ),
                  Slider(
                    value: widget._continuousValue,
                    onChanged: (value) {
                      setState(() {
                        widget._continuousValue = value;
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
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
