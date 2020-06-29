import 'package:flutter/material.dart';

import '../app_localizations.dart';

class BiFuelPage extends StatefulWidget {
  @override
  _BiFuelPageState createState() => _BiFuelPageState();

  int _continuousValue = 70;
}

class _BiFuelPageState extends State<BiFuelPage> {
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
                        widget._continuousValue = newValue.clamp(0, 100) as int;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
