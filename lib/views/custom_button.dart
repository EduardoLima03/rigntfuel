import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  double screen;
  String text;
  final Function roter;

  CustomButton({this.text, this.screen, this.roter});

  /// Estilo do Botão

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
          child: Text(
            text,
            style: _getStyle(),
          ),
          onPressed: roter()),
    );
  }

  _getStyle() {
    return TextStyle(
      color: Colors.white,
      //fontSize: screen <= 425 ? 14 : 18,
    );
  }
}
