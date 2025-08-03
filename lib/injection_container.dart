import 'package:crypto_tracker_app/features/GetCoinGraph/data/datasources/coin_graph_remote_data_source.dart';
import 'package:crypto_tracker_app/features/GetCoinGraph/data/repositories/coin_graph_repository_impl.dart';
import 'package:crypto_tracker_app/features/GetCoinGraph/domain/repositories/coin_graph_repository.dart';
import 'package:crypto_tracker_app/features/GetCoinGraph/domain/usecases/get_coin_graph.dart';
import 'package:crypto_tracker_app/features/GetCoinGraph/presentation/bloc/getcoingraph_bloc.dart';
import 'package:crypto_tracker_app/features/GetCoinList/data/datasources/coin_list_remote_data_source.dart';
import 'package:crypto_tracker_app/features/GetCoinList/data/repositories/coin_list_repository_impl.dart';
import 'package:crypto_tracker_app/features/GetCoinList/domain/repositories/coin_list_repository.dart';
import 'package:crypto_tracker_app/features/GetCoinList/domain/usecases/get_coin_list.dart';
import 'package:crypto_tracker_app/features/GetCoinList/presentation/bloc/getcoinlist_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init () async {
  sl.registerSingleton<http.Client>(http.Client());

  sl.registerLazySingleton<CoinListRemoteDataSource>(() => CoinListRemoteDataSourceImpl(client: sl(), apiKey: dotenv.env['API_KEY']!));

  sl.registerLazySingleton<CoinListRepository>(() => CoinListRepositoryImpl(dataSource: sl()));

  sl.registerLazySingleton(() => GetCoinList(repository: sl()));

  sl.registerFactory(() => GetcoinlistBloc(getCoinList: sl()));


  sl.registerLazySingleton<CoinGraphRemoteDataSource>(()=>CoinGraphRemoteDataSourceImpl(client: sl(), apiKey: dotenv.env['API_KEY']!));

  sl.registerLazySingleton<CoinGraphRepository>(()=>CoinGraphRepositoryImpl(dataSource: sl()));

  sl.registerLazySingleton(()=>GetCoinGraph(coinGraphRepository: sl()));

  sl.registerFactory(()=>GetcoingraphBloc(sl()));


}