import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<int> {
  MainCubit() : super(0);

  void add() => emit(state + 1);

  void remove() => emit(max(0, state - 1));
}
