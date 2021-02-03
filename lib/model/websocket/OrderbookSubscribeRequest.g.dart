// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderbookSubscribeRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderbookSubscribeRequest _$OrderbookSubscribeRequestFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['T', 'S', 'd']);
  return OrderbookSubscribeRequest(
    pairId: json['S'] as String,
    depth: json['d'] as int,
    type: json['T'] as String,
  );
}

Map<String, dynamic> _$OrderbookSubscribeRequestToJson(OrderbookSubscribeRequest instance) => <String, dynamic>{
      'T': instance.type,
      'S': instance.pairId,
      'd': instance.depth,
    };
