import 'dart:typed_data';

// ignore: import_of_legacy_library_into_null_safe
import 'package:pointycastle/api.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:pointycastle/digests/blake2b.dart';

class WavesCrypto {

  final _blake = Blake2bDigest(digestSize: 32);
  final _keccak = Digest("Keccak/256");
  final _sha256 = Digest("SHA-256");

  List<int> keccak(List<int> input) {
    return _keccak.process(_blake.process(Uint8List.fromList(input)));
  }
  
  List<int> sha256(List<int> input) {
    return _sha256.process(Uint8List.fromList(input));
  }
}
