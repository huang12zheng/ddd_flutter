import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
      builder: (context, state) {
        if (state is Empty) {
          return MessageDisplay(message: 'Start searching!');
        } else if (state is Loading) {
          return LoadingWidget();
        } else if (state is Loaded) {
          return TriviaDisplay(numberTrivia: state.trivia);
        } else if (state is Error) {
          return MessageDisplay(message: state.message);
        }
        return Text('');
      },
    );
  }
}
