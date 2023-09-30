import 'package:joke_app/features/joke/data/models/joke_model.dart';
import 'package:joke_app/features/joke/domain/enities/get_joke_entity.dart';

class JokeResponseModel extends GetJokeEntity {
  final Joke joke;

  const JokeResponseModel({
    required this.joke,
  }) : super(jokeEntity: joke);

  factory JokeResponseModel.fromJson(Map<String, dynamic>? json) {
    return JokeResponseModel(
      joke: Joke.fromJson(json ?? {}),
    );
  }

  factory JokeResponseModel.empty() {
    return JokeResponseModel(joke: Joke.empty());
  }
}
