import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;
import 'package:http/http.dart' as http;
import '../extensions/app_ext.dart';
import '../model/user.dart';

typedef MyHttpClient = http.Client;

@immutable
class UserService {
  final MyHttpClient httpClient;

  UserService() : httpClient = MyHttpClient();

  Future<List<User>> fetchUser(UserUrl url) async {
    final response = await httpClient.get(Uri.parse(url.urlToString));

    return (json.decode(response.body) as List<dynamic>)
        .map((dynamic user) => User.fromJson(UserMap.from(user)))
        .cast<User>()
        .toList();
  }
}
