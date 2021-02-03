import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/model/websocket/OrderbookResponse.dart';
import 'package:flutter_test_app/model/websocket/OrderbookSubscribeRequest.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'model/websocket/Orderbook.dart';

class OrderbookPage extends StatefulWidget {
  OrderbookPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _OrderbookPageState();
}

class _OrderbookPageState extends State<OrderbookPage> {
  Orderbook? _orderbook;

  WebSocketChannel? _webSocketChannel;

  StreamSubscription? _subscription;

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel().then((value) => _webSocketChannel?.sink?.close());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildOrderList(_orderbook),
    );
  }

  @override
  void initState() {
    super.initState();
    _webSocketChannel = IOWebSocketChannel.connect("wss://matcher.waves.exchange/ws/v0");

    _subscription = _webSocketChannel?.stream?.listen((event) {
      handleMessage(event);
    }, onDone: () {
      print("ololog websocket closed");
    }, onError: (error) {
      print("ololog websocket error $error");
    }, cancelOnError: true);
  }

  void handleMessage(event) {
    print("ololog websocket event $event");
    final Map<String, dynamic> json = jsonDecode(event);
    final String type = json["T"];

    switch (type) {
      case "pp":
        _sendPing(event);
        break;
      case "i":
        _subscribeToOrderbookUpdates();
        break;
      case "ob":
        _processOrderbook(json);
        break;
    }
  }

  void _processOrderbook(Map<String, dynamic> json) {
    final orderbookResponse = OrderbookResponse.fromJson(json);
    setState(() {
      final snapshot = _orderbook;
      if (snapshot == null && orderbookResponse.updateNumber == 0) {
        _orderbook = Orderbook.fromResponse(orderbookResponse);
      } else if (snapshot != null && orderbookResponse.updateNumber > 0) {
        _orderbook = snapshot.reduce(Orderbook.fromResponse(orderbookResponse));
      }
    });
  }

  void _subscribeToOrderbookUpdates() {
    final pairId = "$WAVES_ID-$BTC_ID";
    final request = jsonEncode(OrderbookSubscribeRequest(pairId: pairId, depth: 10).toJson());
    print("ololog $request");
    _webSocketChannel?.sink.add(request);
  }

  void _sendPing(event) {
    _webSocketChannel?.sink.add(event);
  }

  Widget _buildOrderList(Orderbook? orderbook) {
    final asks = orderbook == null ? List<OrderbookItem>.empty() : orderbook.asks;
    final bids = orderbook == null ? List<OrderbookItem>.empty() : orderbook.bids;
    final items = asks + bids;
    return ListView.builder(
        itemCount: (asks + bids).length,
        itemBuilder: (context, index) {
          final item = items[index];
          final bool isAsk = asks.contains(item);

          return ListTile(
              title: Text("amount: ${item.amount}, price: ${item.price}",
                  style: TextStyle(color: isAsk ? Colors.red : Colors.blue)));
        });
  }
}

const WAVES_ID = "WAVES";
const BTC_ID = "8LQW8f7P5d5PZM7GtZEBgaqRPGSzS3DfPuiXrURJ4AJS";
