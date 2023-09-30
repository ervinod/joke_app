import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'joke_model.g.dart';

Uuid uuid = const Uuid();

@HiveType(typeId: 1)
class Joke extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String joke;

  Joke({String? id, required this.joke}) : id = id ?? uuid.v4();

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      id: json["id"] ?? uuid.v4(),
      joke: json["joke"] ?? '',
    );
  }

  factory Joke.empty() {
    return Joke(id: '', joke: '');
  }

  @override
  List<Object> get props => [id, joke];

  @override
  String toString() => 'Todo(id: $id, joke: $joke)';
}
