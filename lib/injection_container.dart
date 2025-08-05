import 'package:crypto_tracker_app/features/Bookmarks/data/datasources/bookmark_local_data_source.dart';
import 'package:crypto_tracker_app/features/Bookmarks/data/repositories/bookmark_repository_impl.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/repositories/bookmark_repository.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/usecases/add_bookmark.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/usecases/get_all_bookmarked.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/usecases/is_bookmarked.dart';
import 'package:crypto_tracker_app/features/Bookmarks/domain/usecases/remove_bookmark.dart';
import 'package:crypto_tracker_app/features/Bookmarks/presentation/bloc/bookmarks_bloc.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

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


  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  sl.registerLazySingleton<BookmarkLocalDataSource>(()=>BookmarkLocalDataSourceImpl(sp: sl()));

  sl.registerLazySingleton<BookmarkRepository>(()=>BookmarkRepositoryImpl(dataSource: sl()));

  sl.registerLazySingleton(()=>AddBookmark(repository: sl()));
  
  sl.registerLazySingleton(()=>RemoveBookmark(repository: sl()));

  sl.registerLazySingleton(() => GetAllBookmarked(repository: sl()));

  sl.registerLazySingleton(()=>IsBookmarked(repository: sl()));

  sl.registerFactory(()=>BookmarksBloc(sl(), sl(), sl(), sl()));

}