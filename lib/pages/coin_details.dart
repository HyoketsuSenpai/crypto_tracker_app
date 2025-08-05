import 'package:crypto_tracker_app/features/GetCoinGraph/presentation/bloc/getcoingraph_bloc.dart';
import 'package:crypto_tracker_app/features/GetCoinGraph/presentation/widgets/coin_graph.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/entities/coin.dart'
    as bookmark_coin;
import 'package:crypto_tracker_app/features/GetCoinList/domain/entities/coin.dart';
import 'package:crypto_tracker_app/features/GetCoinList/presentation/pages/get_coin_list_page.dart';
import 'package:crypto_tracker_app/features/GetCoinList/presentation/widgets/bookmark_icon.dart';
import 'package:crypto_tracker_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoinDetails extends StatefulWidget {
  final Coin coin;

  const CoinDetails({super.key, required this.coin});

  @override
  State<CoinDetails> createState() => _CoinDetailsState();
}

enum Days { one, seven, thirty, year }

class _CoinDetailsState extends State<CoinDetails> {
  int dayindex = 0;

  static const List<(Days, int)> daysOptions = [
    (Days.one, 1),
    (Days.seven, 7),
    (Days.thirty, 30),
    (Days.year, 365),
  ];

  static const List<String> daysName = ['1D', '1W', '1M', '1Y'];

  final List<bool> _toggleButtonsSelection = daysOptions
      .map((e) => e.$1 == Days.one)
      .toList();

  @override
  Widget build(BuildContext context) {
    bookmark_coin.Coin bookmarkCoin = bookmark_coin.Coin(
      id: widget.coin.id,
      name: widget.coin.name,
      symbol: widget.coin.symbol,
      image: widget.coin.image,
      currentPrice: widget.coin.currentPrice,
      priceChangePercentage24h: widget.coin.priceChangePercentage24h,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coin.name),
        centerTitle: true,
        actions: [BookmarkIcon(coin: bookmarkCoin)],
      ),
                

      body: BlocProvider<GetcoingraphBloc>(
        create: (context) => sl<GetcoingraphBloc>()
          ..add(
            GetCoinGraphEvent(
              id: widget.coin.id,
              days: daysOptions[dayindex].$2,
            ),
          ),
        child: Builder(
          builder: (context) => Column(
            children: [
              CoinGraph(days: daysOptions[dayindex].$2, id: widget.coin.id),

              ToggleButtons(
                isSelected: _toggleButtonsSelection,
                onPressed: (int index) {
                  setState(() {
                    dayindex = index;
                    for (int i = 0; i < _toggleButtonsSelection.length; i++) {
                      _toggleButtonsSelection[i] = i == index;
                    }
                  });
                  context.read<GetcoingraphBloc>().add(
                    GetCoinGraphEvent(
                      id: widget.coin.id,
                      days: daysOptions[index].$2,
                    ),
                  );
                },
                constraints: const BoxConstraints(
                  minHeight: 32.0,
                  minWidth: 56.0,
                ),
                children: daysOptions
                    .map(
                      ((Days, int) day) =>
                          Text(daysName[daysOptions.indexOf(day)]),
                    )
                    .toList(),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '% change 24HR',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$ change 24HR',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${widget.coin.priceChangePercentage24h}'),
                            Text('${widget.coin.priceChange24h}'),
                          ],
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Price',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Market Cap',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${widget.coin.currentPrice}'),
                            Text('${widget.coin.marketCap}'),
                          ],
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '24HR Low',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '24HR High',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${widget.coin.low24h}'),
                            Text('${widget.coin.high24h}'),
                          ],
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ATL',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'ATH',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${widget.coin.atl}'),
                            Text('${widget.coin.ath}'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
