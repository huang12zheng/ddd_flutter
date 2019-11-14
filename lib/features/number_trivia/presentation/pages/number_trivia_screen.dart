import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';
import 'package:tdd_clean_architecture/features/number_trivia/presentation/bloc/number_trivia_state%20copy.dart' as prefix0;
import 'package:tdd_clean_architecture/features/number_trivia/presentation/widgets/widgets.dart';
import 'package:tdd_clean_architecture/features/number_trivia/presentation/bloc/bloc.dart';

class NumberTriviaScreen extends StatefulWidget {
  NumberTriviaScreen({Key key}) : super(key: key);

  @override
  _NumberTriviaScreenState createState() => _NumberTriviaScreenState();
}

class _NumberTriviaScreenState extends State<NumberTriviaScreen> {
  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
    //   builder: (context, state) => state.build()
    // );
    SealedBlocBuilder4<NumberTriviaBloc, NumberTriviaState, Empty, Loading, Loaded,
            Error>(
          builder: (context, states) => states(
            (initial) => initial.build(),
            (loading) => loading.build(),
            (success) => success.build(),
            (failure) => failure.build(),
          ),
        );
  }
}
