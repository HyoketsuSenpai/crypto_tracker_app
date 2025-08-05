import 'package:crypto_tracker_app/features/Bookmarks/presentation/pages/bookmark_page.dart';
import 'package:crypto_tracker_app/features/GetCoinList/presentation/bloc/getcoinlist_bloc.dart';
import 'package:crypto_tracker_app/injection_container.dart';
import 'package:crypto_tracker_app/pages/coin_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetCoinListPage extends StatefulWidget {
  const GetCoinListPage({super.key});

  @override
  State<GetCoinListPage> createState() => _GetCoinListPageState();
}

class _GetCoinListPageState extends State<GetCoinListPage> {
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GetcoinlistBloc>()..add(GetCoinListEvent(page)),
      child: Builder(
        builder: (context) => Scaffold(
          drawer: Drawer(
            child: ListView(
              children: [
                DrawerHeader(child: Text('Navigatation')),
                ListTile(title: Text('home'), tileColor: Colors.grey),
                ListTile(
                  title: Text('Bookmarks'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => BookmarkPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          
          appBar: AppBar(title: Text('Home')),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (page > 1) {
                        page -= 1;
                      }
                      context.read<GetcoinlistBloc>().add(
                        GetCoinListEvent(page),
                      );
                    });
                  },
                  icon: Icon(Icons.arrow_left),
                ),
                Text('Page: $page'),
                IconButton(
                  onPressed: () {
                    setState(() {
                      page += 1;
                    });
                    context.read<GetcoinlistBloc>().add(GetCoinListEvent(page));
                  },
                  icon: Icon(Icons.arrow_right),
                ),
              ],
            ),
          ),
          body: BlocBuilder<GetcoinlistBloc, GetcoinlistState>(
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      color:
                                          (coin.priceChangePercentage24h >= 0)
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                  Text(
                                    '${coin.priceChangePercentage24h}',
                                    style: TextStyle(
                                      color:
                                          (coin.priceChangePercentage24h >= 0)
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    
                    );
                  },
                );
              }

              return Text('Error: Unknown state');
            },
          ),
        ),
      ),
    );
  }
}
