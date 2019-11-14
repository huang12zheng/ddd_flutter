import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:tdd_clean_architecture/features/number_trivia/presentation/widgets/widgets.dart';

import '../../domain/entities/number_trivia.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  Widget build();
}

class Empty extends NumberTriviaState {
  @override
  List<Object> get props => [];

  @override
  Widget build() {
    return MessageDisplay(message: 'Start searching!');
  }
}

class Loading extends NumberTriviaState {
  @override
  List<Object> get props => [];

  @override
  Widget build() {
    return LoadingWidget();
  }
}

class Loaded extends NumberTriviaState {
  final NumberTrivia trivia;
  Loaded({@required this.trivia});

  @override
  List<Object> get props => [trivia];

  @override
  Widget build() {
    return TriviaDisplay(numberTrivia: trivia);
  }
}

class Error extends NumberTriviaState {
  final String message;
  Error({@required this.message});

  @override
  List<Object> get props => [message];

  @override
  Widget build() {
    return MessageDisplay(message: message);
  }
}