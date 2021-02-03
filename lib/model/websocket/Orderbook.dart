import 'package:decimal/decimal.dart';
import 'package:flutter_test_app/model/websocket/OrderbookResponse.dart';

class Orderbook {
  Orderbook(
      {required this.type,
      required this.pairId,
      required this.updateNumber,
      required this.asks,
      required this.bids,
      required this.lastTrade});

  final String type;
  final String pairId;
  final int updateNumber;

  final List<OrderbookItem> asks;
  final List<OrderbookItem> bids;
  final List<String>? lastTrade;

  static Orderbook fromResponse(OrderbookResponse response) {
    final responseAsks = response.asks;
    var asks = responseAsks == null
        ? List<OrderbookItem>.empty()
        : responseAsks.map((e) => OrderbookItem(price: Decimal.parse(e[0]), amount: Decimal.parse(e[1]))).toList();
    asks.sort((a, b) => a.price.compareTo(b.price));

    final responseBids = response.bids;
    var bids = responseBids == null
        ? List<OrderbookItem>.empty()
        : responseBids.map((e) => OrderbookItem(price: Decimal.parse(e[0]), amount: Decimal.parse(e[1]))).toList();
    bids.sort((a, b) => a.price.compareTo(b.price));

    return Orderbook(
        type: response.type,
        pairId: response.pairId,
        updateNumber: response.updateNumber,
        asks: asks.reversed.toList(),
        bids: bids,
        lastTrade: response.lastTrade);
  }

  Orderbook? reduce(Orderbook update) {
    final List<OrderbookItem> snapshotAsks = this.asks;
    final List<OrderbookItem> updateAsks = update.asks;

    snapshotAsks.removeWhere((snapshotAsk) => updateAsks.any((updateAsk) => updateAsk.price == snapshotAsk.price));

    final newAsks = snapshotAsks + updateAsks;

    newAsks.removeWhere((element) => element.amount == Decimal.zero);
    newAsks.sort((a, b) => a.price.compareTo(b.price));

    final List<OrderbookItem> snapshotBids = this.bids;
    final List<OrderbookItem> updateBids = update.bids;

    snapshotAsks.removeWhere((snapshotBid) => updateBids.any((updateBid) => updateBid.price == snapshotBid.price));

    final newBids = snapshotBids + updateBids;
    newBids.removeWhere((element) => element.amount == Decimal.zero);
    newBids.sort((a, b) => a.price.compareTo(b.price));

    return Orderbook(
        type: update.type,
        pairId: update.pairId,
        updateNumber: update.updateNumber,
        asks: newAsks.reversed.toList(),
        bids: newBids,
        lastTrade: update.lastTrade);
  }
}

class OrderbookItem {
  OrderbookItem({required this.amount, required this.price});

  final Decimal amount;
  final Decimal price;
}
