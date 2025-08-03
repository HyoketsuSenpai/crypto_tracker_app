import 'package:crypto_tracker_app/core/error/failure.dart';
import 'package:crypto_tracker_app/features/GetCoinGraph/domain/entities/time_price.dart';
import 'package:crypto_tracker_app/features/GetCoinGraph/domain/usecases/get_coin_graph.dart';
import 'package:crypto_tracker_app/features/GetCoinGraph/presentation/bloc/getcoingraph_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<GetCoinGraph>()])
import 'getcoingraph_bloc_test.mocks.dart';

void main() {
  late MockGetCoinGraph mockGetCoinGraph;
  late GetcoingraphBloc bloc;

  setUp(() {
    mockGetCoinGraph = MockGetCoinGraph();
    bloc = GetcoingraphBloc(mockGetCoinGraph);
  });

  String tId = '1';
  int tDays = 1;

  List<TimePrice> tpoints = [
    TimePrice(time: DateTime(1), price: 1.0),
    TimePrice(time: DateTime(1), price: 1.0),
  ];

  group('Get Coin Graph bloc', () {
    test('initial should be [Empty]', () {
      expect(bloc.state, Empty());
    });

    test('Should use the usecase', () async {
      when(mockGetCoinGraph(any)).thenAnswer((_) async => Right(tpoints));

      bloc.add(GetCoinGraphEvent(id: tId, days: tDays));

      await untilCalled(mockGetCoinGraph(any));

      verify(mockGetCoinGraph(Params(id: tId, days: tDays)));
    });

    test('Should emit [Loading, Loaded] when usecase works', () async {
      when(mockGetCoinGraph(any)).thenAnswer((_) async => Right(tpoints));

      final expected = [Loading(), Loaded(points: tpoints)];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(GetCoinGraphEvent(id: tId, days: tDays));
    });

    test('Should emit [Loading, Error] when usecase does not works', () async {
      when(mockGetCoinGraph(any)).thenAnswer((_) async => Left(ServerFailure()));

      final expected = [Loading(), Error(message: 'error message')];

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(GetCoinGraphEvent(id: tId, days: tDays));
    });
  });
}
