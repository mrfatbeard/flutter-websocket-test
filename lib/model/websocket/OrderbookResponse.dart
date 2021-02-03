import 'package:json_annotation/json_annotation.dart';

part 'OrderbookResponse.g.dart';

@JsonSerializable()
class OrderbookResponse {
  OrderbookResponse(
      {required this.type, required this.pairId, required this.updateNumber, this.asks, this.bids, this.lastTrade});

  factory OrderbookResponse.fromJson(Map<String, dynamic> json) => _$OrderbookResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderbookResponseToJson(this);

  @JsonKey(name: "T")
  final String type;
  @JsonKey(name: "S")
  final String pairId;
  @JsonKey(name: "U")
  final int updateNumber;

  @JsonKey(name: "a")
  final List<List<String>>? asks;
  @JsonKey(name: "b")
  final List<List<String>>? bids;
  @JsonKey(name: "t")
  final List<String>? lastTrade;
}
