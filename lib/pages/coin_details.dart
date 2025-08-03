import 'package:crypto_tracker_app/features/GetCoinGraph/presentation/widgets/coin_graph.dart';
import 'package:crypto_tracker_app/features/GetCoinList/domain/entities/coin.dart';
import 'package:flutter/material.dart';

class CoinDetails extends StatefulWidget {
  final Coin coin;

  const CoinDetails({super.key, required this.coin});

  @override
  State<CoinDetails> createState() => _CoinDetailsState();
}

class _CoinDetailsState extends State<CoinDetails> {
  int days = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coin.name),
        centerTitle: true,
        actions: [
          // un/bookmark coins
        ],
      ),
      body: Column(
        children: [
          CoinGraph(days: days, id: widget.coin.id),
          Placeholder(), //coin data
        ],
      ),
    );
  }
}
