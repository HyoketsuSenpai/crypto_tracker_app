import 'package:crypto_tracker_app/features/Bookmarks/presentation/bloc/bookmarks_bloc.dart';
import 'package:crypto_tracker_app/features/GetCoinList/presentation/pages/get_coin_list_page.dart';
import 'package:crypto_tracker_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarks')),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text('Navigatation')),
            ListTile(
              title: Text('home'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => GetCoinListPage()),
                );
              },
            ),
            ListTile(title: Text('Bookmarks'), tileColor: Colors.grey),
          ],
        ),
      ),
      body: BlocProvider<BookmarksBloc>(
        create: (context) => sl<BookmarksBloc>()..add(GetBookmarksEvent()),
        child: BlocBuilder<BookmarksBloc, BookmarksState>(
          builder: (context, state) {
            if (state is Loading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is Error) {
              return Center(child: Text(state.message));
            }
            if (state is BookmarkList) {
              final coins = state.coins;
              if (coins.isEmpty) {
                return Center(child: Text('No bookmarks found'));
              }
              return ListView.builder(
                itemCount: coins.length,
                itemBuilder: (context, index) {
                  final coin = coins[index];
                  return  Card(
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
                      );
                    
                },
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

}
