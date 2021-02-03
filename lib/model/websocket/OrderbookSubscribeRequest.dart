import 'package:json_annotation/json_annotation.dart';

part 'OrderbookSubscribeRequest.g.dart';

@JsonSerializable()
class OrderbookSubscribeRequest {
  OrderbookSubscribeRequest({required this.pairId, required this.depth, this.type: "obs"});

  factory OrderbookSubscribeRequest.fromJson(Map<String, dynamic> json) => _$OrderbookSubscribeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderbookSubscribeRequestToJson(this);

  @JsonKey(name: "T", required: true)
  final String type;

  @JsonKey(name: "S", required: true)
  final String pairId;

  @JsonKey(name: "d", required: true)
  final int depth;
}
