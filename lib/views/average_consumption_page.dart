import 'package:flutter/material.dart';

class AverageConsumptionPage extends StatefulWidget {
  @override
  _AverageConsumptionPageState createState() => _AverageConsumptionPageState();
}

class _AverageConsumptionPageState extends State<AverageConsumptionPage> {
  final _initialOdometer = TextEditingController();
  final _finalOdometer = TextEditingController();
  final _fuel = TextEditingController();

  bool _enableValidator() {
    setState(() {
      _initialOdometer.text.length > 0 && _initialOdometer.text.length <= 3
          ? false
          : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Averege Consumption'),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
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
                  labelText: 'Initial Odometer',
                  hintText: '',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 6,
                enabled: _enableValidator(),
                controller: _finalOdometer,
                decoration: InputDecoration(
                  labelText: 'Final Odometer',
                  hintText: '',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _fuel,
                decoration: InputDecoration(
                  labelText: "Fuel",
                  hintText: '',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                  child: Text(
                    'Calculator',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Theme.of(context).accentColor,
                  onPressed: null),
            ],
          ),
        ),
      ),
    );
  }
}
