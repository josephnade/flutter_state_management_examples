// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math' as math show Random;

import 'package:bloc/bloc.dart';

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

class NamesCubit extends Cubit<String?> {
  Iterable<String> userList;
  NamesCubit({required this.userList}) : super(null);
  void getRandomName() => emit(userList.getRandomElement());
}
