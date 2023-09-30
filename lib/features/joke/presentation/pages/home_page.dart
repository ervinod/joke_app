import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joke_app/features/joke/presentation/blocs/joke_bloc.dart';
import 'package:joke_app/injection_container.dart';

import '../widgets/header.dart';
import '../widgets/joke_list_view.dart';

class JokePage extends StatefulWidget {
  const JokePage({Key? key}) : super(key: key);

  @override
  State<JokePage> createState() => _JokePageState();
}

class _JokePageState extends State<JokePage> {
  late Timer timer;
  late JokeBloc jokeBloc;

  @override
  void initState() {
    /// joke api call
    jokeBloc = sl<JokeBloc>()..add(const GetJokeEvent());
    timer = Timer.periodic(
      const Duration(seconds: 60),
      (Timer timer) {
        /// fetch new joke at interval of 1 min
        jokeBloc.add(const GetJokeEvent());
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          child: Column(
            children: const [
              Header(
                key: Key("header"),
              ),
              Expanded(
                child: JokeListView(
                  key: Key("jokeListView"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
