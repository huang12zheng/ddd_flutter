import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';
import 'package:tdd_clean_architecture/features/number_trivia/presentation/widgets/widgets.dart';

import '../../domain/entities/number_trivia.dart';

class NumberTriviaState extends Union4Impl<Empty,Loading,Loaded,Error> {
  static final unions = const Quartet<Empty,Loading,Loaded,Error>();
  NumberTriviaState._(Union4<Empty, Loading, Loaded, Error> union) : super(union);

  // const NumberTriviaState();
  // it is need to refactor
  // Widget build();

  factory NumberTriviaState.initial() => NumberTriviaState._(unions.first(Empty()));

  factory NumberTriviaState.loading() => NumberTriviaState._(unions.second(Loading()));

  factory NumberTriviaState.success({NumberTrivia data}) =>
      NumberTriviaState._(unions.third(Loaded(trivia: data)));

  factory NumberTriviaState.failure({String error}) =>
      NumberTriviaState._(unions.fourth(Error(message: error)));
}

class Empty {
  @override
  List<Object> get props => [];

  Widget build() {
    return MessageDisplay(message: 'Start searching!');
  }
}

class Loading {
  @override
  List<Object> get props => [];

  Widget build() {
    return LoadingWidget();
  }
}

class Loaded {
  final NumberTrivia trivia;
  Loaded({@required this.trivia});

  @override
  List<Object> get props => [trivia];

  Widget build() {
    return TriviaDisplay(numberTrivia: trivia);
  }
}

class Error {
  final String message;
  Error({@required this.message});

  @override
  List<Object> get props => [message];

  Widget build() {
    return MessageDisplay(message: message);
  }
}