
import 'package:crypto_tracker_app/injection_container.dart';
import 'package:crypto_tracker_app/pages/coin_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../presentation/bloc/getcoinlist_bloc.dart';

class GetCoinListPage extends StatefulWidget {
  const GetCoinListPage({super.key});

  @override
  State<GetCoinListPage> createState() => _GetCoinListPageState();
}

class _GetCoinListPageState extends State<GetCoinListPage> {
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crypto tracker app')),
      body: BlocProvider(
        create: (context) => sl<GetcoinlistBloc>()..add(GetCoinListEvent(page)),
        child: BlocBuilder<GetcoinlistBloc, GetcoinlistState>(
          builder: (context, state) {
            if (state is Loading) {
              return Center(child: CircularProgressIndicator());
            }
        
            if (state is Error) {
              return Center(child: Text(state.message));
            }
        
            if (state is Loaded) {
              return ListView.builder(
                itemCount: state.coins.length,
                itemBuilder: (context, index) {
                  final coin = state.coins[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CoinDetails(coin: coin),
                      ),
                    ),
                    child: Card(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(coin.image),
                          ),
                          Column(
                            children: [Text(coin.name), Text(coin.symbol)],
                          ),
                          Column(
                            children: [
                              Text(
                                '${coin.currentPrice}',
                                style: TextStyle(
                                  color: (coin.priceChangePercentage24h >= 0)
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              Text(
                                '${coin.priceChangePercentage24h}',
                                style: TextStyle(
                                  color: (coin.priceChangePercentage24h >= 0)
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
        
            return Text('hello');
          },
        ),
      ),
    );
  }
}
