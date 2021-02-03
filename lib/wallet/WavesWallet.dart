import 'dart:convert';

import 'package:flutter_test_app/wallet/PrivateKeyAccount.dart';

class WavesWallet {
  WavesWallet._(this._seed, this.account);

  static Future<WavesWallet> create(String seed) async {
    final account = await PrivateKeyAccount.create(utf8.encode(seed));
    return WavesWallet._(seed, account);
  }

  final String _seed;
  final PrivateKeyAccount account;
}
