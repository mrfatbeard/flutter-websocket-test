// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderbookResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderbookResponse _$OrderbookResponseFromJson(Map<String, dynamic> json) {
  return OrderbookResponse(
    type: json['T'] as String,
    pairId: json['S'] as String,
    updateNumber: json['U'] as int,
    asks: (json['a'] as List<dynamic>?)?.map((e) => (e as List<dynamic>).map((e) => e as String).toList()).toList(),
    bids: (json['b'] as List<dynamic>?)?.map((e) => (e as List<dynamic>).map((e) => e as String).toList()).toList(),
    lastTrade: (json['t'] as List<dynamic>?)?.map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$OrderbookResponseToJson(OrderbookResponse instance) => <String, dynamic>{
      'T': instance.type,
      'S': instance.pairId,
      'U': instance.updateNumber,
      'a': instance.asks,
      'b': instance.bids,
      't': instance.lastTrade,
    };
