import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations.dart';
import 'src/views/bicombustivel_Activity.dart';
import 'src/views/consumo_medio_Activity.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "RigntFuel",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // List all of the app's suportde locales here
      supportedLocales: [
        Locale('en', 'US'),
        Locale('pt', 'BR'),
        Locale('es', 'US'),
        Locale('es', 'BR'),
      ],
      // these delegates make sure that the localization data for proper lenguage is loaded
      localizationsDelegates: [
        // Class que vai fazer a tradução
        AppLocalizations.delegate,

        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      // Returns a locale which will be used by the app
      localeResolutionCallback: (locale, supportedLocales) {
        // Check if locale which will be used by the app
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },

      home: MyHomePage(title: 'RigntFuel'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //dynamic deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ConsumoMedioActivity()));
              },
              child: Text(
                AppLocalizations.of(context).translate('consumption'),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Theme.of(context).accentColor,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BiCombustivelActivity()));
              },
              child: Text(
                AppLocalizations.of(context).translate('bifuel'),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Theme.of(context).accentColor,
            ),
          ],
        ),
      ),
    );
  }
}
