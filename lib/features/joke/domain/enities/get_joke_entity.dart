import 'package:equatable/equatable.dart';

import '../../data/models/joke_model.dart';

class GetJokeEntity extends Equatable {
  final Joke jokeEntity;

  const GetJokeEntity({
    required this.jokeEntity,
  });

  GetJokeEntity copyWith({
    required Joke? jokeEntity,
  }) {
    return GetJokeEntity(
      jokeEntity: jokeEntity ?? this.jokeEntity,
    );
  }

  @override
  List<Object?> get props => [jokeEntity];
}
