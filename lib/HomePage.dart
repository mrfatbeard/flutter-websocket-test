import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'wallet/WavesWallet.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title, required this.onSignedIn}) : super(key: key);

  final String title;
  final Function onSignedIn;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _inputController = TextEditingController();
  bool _canLogIn = false;
  String _publicKey = "";

  _HomePageState() {
    _inputController.addListener(() {
      setState(() {
        _canLogIn = _inputController.text.isNotEmpty;
      });
    });
  }

  void _setPublicKey(String publicKey) {
    print("ololog public key = $publicKey");
    setState(() {
      _publicKey = publicKey;
    });
    widget.onSignedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter seed:',
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
                style: TextStyle(color: Colors.black),
                maxLines: 3,
                cursorColor: Colors.red,
                controller: _inputController,
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: Text(
                "public key is $_publicKey",
                textAlign: TextAlign.center,
              ),
            ),
            CupertinoButton.filled(
                child: Text("Sign in"),
                onPressed: _canLogIn
                    ? () {
                        createWallet(_inputController.text)
                            .then((wallet) => _setPublicKey(wallet.account.publicKeyStr()));
                      }
                    : null),
          ],
        ),
      ),
    );
  }

  Future<WavesWallet> createWallet(String seed) async {
    final wallet = await WavesWallet.create(seed);
    return wallet;
  }
}
