import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joke_app/core/database/cache_manager.dart';

import '../../../../core/constants/value_constants.dart';
import '../../../../core/utils/util.dart';
import '../../data/models/joke_model.dart';
import '../../domain/usecases/get_joke_usecase.dart';

part 'joke_event.dart';

part 'joke_state.dart';

class JokeBloc extends Bloc<JokeEvent, GetJokeState> {
  final GetJokeUseCase getJokeUseCase;

  JokeBloc({
    required this.getJokeUseCase,
  }) : super(GetJokeState.initial()) {
    on<GetJokeEvent>(_getJokes);
  }

  Future<void> _getJokes(GetJokeEvent event, Emitter<GetJokeState> emit) async {
    emit(state.copyWith(status: ApiStatus.loading));

    final response = await getJokeUseCase(const GetJokeParams());

    /// in order to show loading shimmer for extended time
    sleep(const Duration(milliseconds: 800));

    Joke joke = Joke.empty();

    response.fold(
      (failure) {
        emit(state.copyWith(
          status: ApiStatus.error,
          error: Utils.mapFailureToMessage(failure),
        ));
      },
      (result) async {
        joke = result.jokeEntity;
      },
    );

    final jokes = await CacheManager.instance.cacheData(joke);
    emit(state.copyWith(
      status: ApiStatus.loaded,
      jokes: jokes,
    ));
  }
}
