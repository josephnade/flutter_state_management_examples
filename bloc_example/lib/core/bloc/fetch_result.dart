part of 'user_bloc.dart';

@immutable
class FetchResult {
  final bool isCache;
  final Iterable<User> users;

  const FetchResult({
    this.users = const [],
    this.isCache = false,
  });

  @override
  bool operator ==(covariant FetchResult other) {
    return users.isEqualOrIgnoring(other.users) && isCache == other.isCache;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => Object.hash(users, isCache);
}
