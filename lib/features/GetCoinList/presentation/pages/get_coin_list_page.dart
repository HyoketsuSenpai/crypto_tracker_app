import 'package:crypto_tracker_app/features/GetCoinList/presentation/bloc/getcoinlist_bloc.dart';
import 'package:crypto_tracker_app/injection_container.dart';
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
    return Scaffold(
      appBar: AppBar(title: Text('Crypto tracker app'),),
      body: BlocProvider(
        create: (context) => sl<GetcoinlistBloc>()..add(GetCoinListEvent(page)),
        child: Container(
          child: BlocBuilder<GetcoinlistBloc, GetcoinlistState>(
            builder: (context, state) {
              
              if(state is Loading) {
                return Center(child: CircularProgressIndicator(),);
              }

              if(state is Error) {
                return Center(child: Text(state.message),);
              }

              if (state is Loaded) {
                return ListView.builder(
                  itemCount: state.coins.length,
                  itemBuilder: (context, index) {
                    final coin = state.coins[index];
                    return ListTile(
                      title: Text(coin.name),
                      subtitle: Text(coin.symbol),
                    );
                  },
                );
              }

              return Text('hello');

            },
          ),
        ),
      ),
    );
  }
}