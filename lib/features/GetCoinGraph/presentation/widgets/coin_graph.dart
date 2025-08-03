import 'package:crypto_tracker_app/features/GetCoinGraph/domain/entities/time_price.dart';
import 'package:crypto_tracker_app/features/GetCoinGraph/presentation/bloc/getcoingraph_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../injection_container.dart';

class CoinGraph extends StatelessWidget {

  final int days;
  final String id;

  const CoinGraph({super.key, required this.days, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetcoingraphBloc>(
        create: (context) =>
            sl<GetcoingraphBloc>()
              ..add(GetCoinGraphEvent(id: id, days: days)),
        child: BlocBuilder<GetcoingraphBloc,GetcoingraphState>(
          builder: (context, state) {
            if (state is Error) {
              return Center(child: Text(state.message));
            }

            if (state is Loading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is Loaded) {
              final points = state.points;
              return SfCartesianChart(
                trackballBehavior: TrackballBehavior(enable: true),
                crosshairBehavior: CrosshairBehavior(enable: true),
                primaryXAxis: DateTimeAxis(),
                primaryYAxis: NumericAxis(numberFormat: NumberFormat.compact()),
                series: <AreaSeries>[
                  AreaSeries<TimePrice, dynamic>(
                    enableTooltip: true,
                    color: Colors.transparent,
                    borderColor: Colors.blue,
                    borderWidth: 2,
                    dataSource: points,

                    xValueMapper: (point, index) => point.time,
                    yValueMapper: (point, index) => point.price,
                  ),
                ],
              );
            }

            return Container();
          },
        ),
      );
  }
}