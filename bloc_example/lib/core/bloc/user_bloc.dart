import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_example/core/extensions/app_ext.dart';
import 'package:meta/meta.dart';

import '../model/user.dart';

part 'load_person.dart';
part 'fetch_result.dart';

typedef PersonLoader = Future<List<User>> Function(UserUrl);

class UserBloc extends Bloc<LoadAction, FetchResult?> {
  UserBloc() : super(null) {
    on<LoadPersonAction>(_onLoadPerson);
  }
  final Map<UserUrl, Iterable<User>> _cached = {};

  Future<void> _onLoadPerson(LoadPersonAction event, Emitter<FetchResult?> emit) async {
    final UserUrl url = event.url;
    if (_cached.containsKey(url)) {
      final cachedUsers = _cached[url]!;

      emit(FetchResult(users: cachedUsers.toList(), isCache: true));
      'Data From Cache'.log();
    } else {
      final PersonLoader personLoader = event.onLoader;
      final List<User> userFromService = await personLoader(url);
      _cached[url] = userFromService;
      emit(FetchResult(users: userFromService, isCache: false));
      'Data From Service'.log();
    }
  }
}
