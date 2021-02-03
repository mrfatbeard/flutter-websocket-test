import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:flutter_test_app/wallet/Ints.dart';
import 'package:flutter_test_app/wallet/WavesCrypto.dart';
import 'package:flutter_test_app/wallet/base58.dart';

class PrivateKeyAccount {
  PrivateKeyAccount._(this.publicKey, this.privateKey);

  static Future<PrivateKeyAccount> create(List<int> bytes) async {
    final WavesCrypto wavesCrypto = WavesCrypto();

    final input = toByteArray(0) + bytes;
    final keccak = wavesCrypto.keccak(input);
    final hashedSeed = wavesCrypto.sha256(keccak);

    final keyPairForPrivateKey = await X25519().newKeyPairFromSeed(hashedSeed);
    final privateKey = await keyPairForPrivateKey.extractPrivateKeyBytes();

    final keyPairForPublicKey = await X25519().newKeyPairFromSeed(privateKey);
    final publicKey = await keyPairForPublicKey.extractPublicKey();
    final publicKeyBytes = publicKey.bytes;

    return PrivateKeyAccount._(publicKeyBytes, privateKey);
  }

  final List<int> privateKey;
  final List<int> publicKey;

  String publicKeyStr() {
    return Base58Encode(publicKey);
  }

  String privateKeyStr() {
    return Base58Encode(privateKey);
  }
}
