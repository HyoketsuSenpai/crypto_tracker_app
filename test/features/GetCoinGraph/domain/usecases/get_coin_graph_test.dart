import 'package:crypto_tracker_app/core/error/failure.dart';
import 'package:crypto_tracker_app/features/GetCoinGraph/domain/entities/time_price.dart';
import 'package:crypto_tracker_app/features/GetCoinGraph/domain/repositories/coin_graph_repository.dart';
import 'package:crypto_tracker_app/features/GetCoinGraph/domain/usecases/get_coin_graph.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<CoinGraphRepository>()])
import 'get_coin_graph_test.mocks.dart';

void main() {
  String tId = 'bitcoin';
  int tDays = 1;

  List<TimePrice> points = [
    TimePrice(time: DateTime(1), price: 1.0),
    TimePrice(time: DateTime(1), price: 1.0),
  ];

  late MockCoinGraphRepository mockRepository;
  late GetCoinGraph usecase;

  setUp(() {
    mockRepository = MockCoinGraphRepository();
    usecase = GetCoinGraph(coinGraphRepository: mockRepository);
  });

  group('GetCoinGraph', () {
    test('Make sure the repo is called', () {
      when(
        mockRepository.getCoinGraph(any, any),
      ).thenAnswer((_) async => Right(points));

      usecase(Params(id: tId, days: tDays));

      verify(mockRepository.getCoinGraph(tId, tDays));
      verifyNoMoreInteractions(mockRepository);
    });

    test(
      'Make sure that it returns a right list of timeprice if repo works',
      () async {
        when(
          mockRepository.getCoinGraph(any, any),
        ).thenAnswer((_) async => Right(points));

        final result = await usecase(Params(id: tId, days: tDays));

        expect(result, Right(points));
      },
    );

    test(
      'Make sure that it returns a left Failure if repo does not works',
      () async {
        when(
          mockRepository.getCoinGraph(any, any),
        ).thenAnswer((_) async => Left(Failure()));

        final result = await usecase(Params(id: tId, days: tDays));

        expect(result, Left(Failure()));
      },
    );

  });

}
