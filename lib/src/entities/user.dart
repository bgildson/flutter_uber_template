import 'dart:math';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
class User extends Equatable {
  final String username;
  final String name;
  final String photoUrl;
  final double rating;

  User({this.username, this.name, this.photoUrl, this.rating})
    : super([username, name, photoUrl, rating]);

  factory User.empty() =>
    User(
      username: 'username',
      name: 'name',
      photoUrl: null,
      rating: 5,
    );

  factory User.fromJson(Map<String, dynamic> json) =>
    User(
      username: json['login']['username'] as String,
      name: json['name']['first'] as String,
      photoUrl: json['picture']['medium'],
      rating: 4 + Random().nextDouble(), // random rating, upper than 4 and lower than 5
    );

  @override
  String toString() =>
    'User { '
    'username: $username, '
    'name: $name, '
    'photoUrl: $photoUrl, '
    'rating: $rating, '
    '}';
}
