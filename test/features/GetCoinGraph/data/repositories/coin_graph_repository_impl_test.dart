import 'package:crypto_tracker_app/core/error/exception.dart';
import 'package:crypto_tracker_app/core/error/failure.dart';
import 'package:crypto_tracker_app/features/GetCoinGraph/data/datasources/coin_graph_remote_data_source.dart';
import 'package:crypto_tracker_app/features/GetCoinGraph/data/models/time_price_model.dart';
import 'package:crypto_tracker_app/features/GetCoinGraph/data/repositories/coin_graph_repository_impl.dart';
import 'package:crypto_tracker_app/features/GetCoinGraph/domain/repositories/coin_graph_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<CoinGraphRemoteDataSource>()])
import 'coin_graph_repository_impl_test.mocks.dart';

void main() {
  String tId = 'bitcoin';
  int tDays = 1;

  List<TimePriceModel> points = [
    TimePriceModel(time: DateTime(1), price: 1.0),
    TimePriceModel(time: DateTime(1), price: 1.0),
  ];

  late MockCoinGraphRemoteDataSource dataSource;
  late CoinGraphRepositoryImpl repositoryImpl;

  setUp(() {
    dataSource = MockCoinGraphRemoteDataSource();
    repositoryImpl = CoinGraphRepositoryImpl(dataSource: dataSource);
  });

  group('Coin Graph Repo Impl', () {
    test('should be a coin graph repo', () {
      expect(repositoryImpl, isA<CoinGraphRepository>());
    });

    test('should use the data source', () {
      when(dataSource.getCoinGraph(any, any)).thenAnswer((_) async => points);

      repositoryImpl.getCoinGraph(tId, tDays);

      verify(dataSource.getCoinGraph(tId, tDays));
    });

    test('should get list when the data source works', () async {
      when(dataSource.getCoinGraph(any, any)).thenAnswer((_) async => points);

      final result = await repositoryImpl.getCoinGraph(tId, tDays);

      expect(result, Right(points));
    });

    test(
      'should return left server failure when the data source throws server exception',
      () async {
        when(
          dataSource.getCoinGraph(any, any),
        ).thenThrow(ServerException());

        final result = await repositoryImpl.getCoinGraph(tId, tDays);

        expect(result, Left(ServerFailure()));
      },
    );
  });

}
