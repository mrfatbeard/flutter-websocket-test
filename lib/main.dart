// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'OrderbookPage.dart';

void main() {
  // FlutterCryptography.enable();
  runApp(App());
}

class App extends StatefulWidget {
  // This widget is the root of your application.

  @override
  State createState() => _AppState();
}

class _AppState extends State<App> {
  bool _signedIn = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Navigator(
          pages: [
            MaterialPage(
              key: ValueKey("HomePage"),
              child: HomePage(
                title: 'Waves Exchange flutter demo',
                onSignedIn: () {
                  setState(() {
                    _signedIn = true;
                  });
                },
              ),
            ),
            if (_signedIn)
              MaterialPage(key: ValueKey("OrderbookPage"), child: OrderbookPage(title: "WAVES/BTC orderbook"))
          ],
          onPopPage: (route, result) => route.didPop(result),
        ));
  }
}
