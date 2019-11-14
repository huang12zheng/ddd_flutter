import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_clean_architecture/core/error/failure.dart';
import 'package:tdd_clean_architecture/core/usecases/usecase.dart';
import 'package:tdd_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tdd_clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import './bloc.dart';
abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();
  Stream<NumberTriviaState> loadAsync(NumberTriviaBloc bloc);
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String numberString;

  GetTriviaForConcreteNumber(this.numberString);

  @override
  List<Object> get props => [numberString];

  loadAsync(NumberTriviaBloc bloc) async *{
    // final GetConcreteNumberTrivia getConcreteNumberTrivia;
    final inputEither =
          bloc.inputConverter.stringToUnsignedInteger(numberString);

      yield* inputEither.fold(
        (failure) async* {
          yield NumberTriviaState.failure(error: INVALID_INPUT_FAILURE_MESSAGE);
        },
        (integer) async* {
          yield NumberTriviaState.loading();
          final failureOrTrivia =
              await bloc.getConcreteNumberTrivia(Params(number: integer));
          yield* _eitherLoadedOrErrorState(failureOrTrivia);
        },
      );
  }
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {
  @override
  List<Object> get props => [];

  @override
  loadAsync(NumberTriviaBloc bloc) async *{
    yield NumberTriviaState.loading();
    final failureOrTrivia = await bloc.getRandomNumberTrivia(NoParams());
    yield* _eitherLoadedOrErrorState(failureOrTrivia);
  }
}


Stream<NumberTriviaState> _eitherLoadedOrErrorState(
  Either<Failure, NumberTrivia> failureOrTrivia,
) async* {
  yield failureOrTrivia.fold(
    (failure) => NumberTriviaState.failure(error: _mapFailureToMessage(failure)),
    (trivia) => NumberTriviaState.success(data: trivia),
  );
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}