import 'package:crypto_tracker_app/core/error/exception.dart';
import 'package:crypto_tracker_app/features/Bookmarks/data/models/coin_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BookmarkLocalDataSource {
  /// Adds the [CoinModel] to cache
  ///
  /// Throws [CacheException]
  Future<Unit> addBookmark(CoinModel coin);

  /// Gets the [List<Coin>] thats cached in memory
  ///
  /// Does not throw any exception
  Future<List<CoinModel>> getAllBookmarked();

  /// Checks for [CoinModel] in cache
  ///
  /// Does not throw any exception
  Future<bool> isBookmarked(CoinModel coin);

  /// Removes the [CoinModel] from cache
  ///
  /// Throws [CacheException]
  Future<Unit> removeBookmark(CoinModel coin);
}

class BookmarkLocalDataSourceImpl implements BookmarkLocalDataSource {
  final SharedPreferences sp;

  BookmarkLocalDataSourceImpl({required this.sp});

  @override
  Future<Unit> addBookmark(CoinModel coin) async {
    try {
      final bookmarkedString = sp.getString('bookmark') ?? '[]';
      List<CoinModel> coins = CoinModel.decode(bookmarkedString);
      coins.add(coin);
      final sucess = await sp.setString('bookmark', CoinModel.encode(coins));
      if (!sucess) {
        throw CacheException();
      }
      return unit;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<CoinModel>> getAllBookmarked() async {
    final bookmarkedString = sp.getString('bookmark') ?? '[]';
    return CoinModel.decode(bookmarkedString);
  }

  @override
  Future<bool> isBookmarked(CoinModel coin) async {
    final bookmarkedString = sp.getString('bookmark') ?? '[]';
    List<CoinModel> coins = CoinModel.decode(bookmarkedString);
    return coins.any((item) => item == coin);
  }

  @override
  Future<Unit> removeBookmark(CoinModel coin) async {
    try {
      final bookmarkedString = sp.getString('bookmark') ?? '[]';
      List<CoinModel> coins = CoinModel.decode(bookmarkedString);
      coins.remove(coin);
      final sucess = await sp.setString('bookmark', CoinModel.encode(coins));
      if (!sucess) {
        throw CacheException();
      }
      return unit;
    } catch (e) {
      throw CacheException();
    }
  }
}
