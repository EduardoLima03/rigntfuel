import 'package:flutter/material.dart';
import 'package:rigntfuel/app_localizations.dart';

class BiCombustivelActivity extends StatefulWidget {
  @override
  _BiCombustivelActivityState createState() => _BiCombustivelActivityState();
}

class _BiCombustivelActivityState extends State<BiCombustivelActivity> {
  double _continuousValue = 70;
  String _mensg = "";

  final _controllerEtanol = TextEditingController(text: "");
  final _controllerGasolina = TextEditingController(text: "");

  void calculo() {
    double porcentegem = _continuousValue / 100;
    double gasolina = double.parse(_controllerGasolina.text);
    double etanol = double.parse(_controllerEtanol.text);

    if ((etanol / gasolina) <= porcentegem) {
      setState(() {
        _mensg = AppLocalizations.of(context).translate('smt_ethanol');
      });
    } else {
      _mensg = AppLocalizations.of(context).translate('smt_gasoline');
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 64,
                  height: 48,
                  child: TextField(
                    textAlign: TextAlign.center,
                    onSubmitted: (value) {
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
                )
              ],
            ),
            TextField(
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context).translate('tax_ethanol'),
                labelStyle: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
                prefixText: "R\$",
              ),
              keyboardType: TextInputType.numberWithOptions(),
              controller: _controllerEtanol,
            ),
            TextField(
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context).translate('tax_gasoline'),
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                prefixText: "R\$",
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
      )),
    );
  }
}
