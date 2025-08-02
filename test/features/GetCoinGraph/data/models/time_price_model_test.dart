

import 'dart:convert';

import 'package:crypto_tracker_app/features/GetCoinGraph/data/models/time_price_model.dart';
import 'package:crypto_tracker_app/features/GetCoinGraph/domain/entities/time_price.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixture_reader.dart';

void main() {

  TimePriceModel tModel = TimePriceModel(time: DateTime.fromMicrosecondsSinceEpoch(1754039970774), price: 115019.9640215161);

  test('Check its a time price', (){
    expect(tModel,isA<TimePrice>());
  });

  test('check from json is working', (){
    List<dynamic> jsonList = json.decode(fixture('coin_graph.json'));

    final result = TimePriceModel.fromJson(jsonList);

    expect(result, tModel);
  });

}