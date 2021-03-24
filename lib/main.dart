import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rigntfuel/views/average_consumption_page.dart';
import 'package:rigntfuel/views/bi_fuel_page.dart';
import 'package:rigntfuel/widgets/admob_widget.dart';

import 'utils/admob_util.dart';
import 'utils/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize(
    testDeviceIds: [AdmobUtil.getAppId()],
  );
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
  @override
  Widget build(BuildContext context) {
    //double _sizedWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('RigntFuel'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                child: Text(
                  AppLocalizations.of(context).translate('consumption'),
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (contex) => AverageConsumptionPage()));
                }),
            ElevatedButton(
                child: Text(
                  AppLocalizations.of(context).translate('bifuel'),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BiFuelPage()));
                }),
            Container(
              child: AdmobWidget(context).getBanner(),
            ),
          ],
        ),
      ),
    );
  }
}
