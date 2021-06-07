import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rigntfuel/views/average_consumption_page.dart';
import 'package:rigntfuel/views/bi_fuel_page.dart';
import 'utils/app_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RigntFuel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
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

      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _indiceAtual = 0;
  final List<Widget> _telas = [
    AverageConsumptionPage(),
    BiFuelPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      this._indiceAtual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //double _sizedWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _telas[_indiceAtual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.directions),
            title: Text(AppLocalizations.of(context).translate('consumption')),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_gas_station),
            title: Text(AppLocalizations.of(context).translate('bifuel')),
          ),
        ],
      ),
    );
  }
}
