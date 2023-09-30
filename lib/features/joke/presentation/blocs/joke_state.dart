part of 'joke_bloc.dart';

abstract class JokeState extends Equatable {
  const JokeState() : super();

  @override
  List<Object> get props => [];
}

class GetJokeState extends JokeState {
  final List<Joke> jokes;
  final ApiStatus status;
  final String error;

  const GetJokeState({
    required this.jokes,
    required this.status,
    this.error = '',
  });

  factory GetJokeState.initial() {
    return const GetJokeState(
      jokes: [],
      status: ApiStatus.initial,
    );
  }

  @override
  List<Object> get props => [jokes, status, error];

  @override
  String toString() =>
      'GetJokeState(jokes: $jokes, status:$status, error:$error)';

  GetJokeState copyWith({
    List<Joke>? jokes,
    ApiStatus? status,
    String? error,
  }) {
    return GetJokeState(
      jokes: jokes ?? this.jokes,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
