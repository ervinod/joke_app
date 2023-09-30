part of 'joke_bloc.dart';

abstract class JokeEvent extends Equatable {
  const JokeEvent();

  @override
  List<Object> get props => [];
}

class GetJokeEvent extends JokeEvent {
  const GetJokeEvent();

  @override
  String toString() => 'GetJokeEvent()';

  @override
  List<Object> get props => [];
}
