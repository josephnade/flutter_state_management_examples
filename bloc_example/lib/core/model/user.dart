// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart' show immutable;

@immutable
class User {
  final int id;
  final String firstName;
  final String email;

  const User({required this.id, required this.firstName, required this.email});

  User.fromJson(UserMap jsonData)
      : id = jsonData['id'],
        firstName = jsonData['first_name'],
        email = jsonData['email'];

  @override
  String toString() => 'FirstName: $firstName, email: $email)';
}

typedef UserMap = Map<String, dynamic>;
