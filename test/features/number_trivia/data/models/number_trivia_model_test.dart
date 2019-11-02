
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_architecture/features/number_trivia/data/models/NumberTriviaModel.dart';
import 'package:tdd_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'Test Text');

  test('should be a subclass of NumberTrivia entity', () {
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group('fromJson', () {
    // 測試整數
    test('should return a valid model when the JSON number is an integer', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, tNumberTriviaModel);
    });
    // 測試double
    test('should return a valid model when the JSON number is regarded as a double', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia_double.json'));
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, tNumberTriviaModel);
    });

  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      final result = tNumberTriviaModel.toJson();
      final expectedJsonMap = {
        'text': 'Test Text',
        'number': 1,
      };
      expect(result, expectedJsonMap);
    });
  });
}