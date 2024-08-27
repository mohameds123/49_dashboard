import 'package:flutter/foundation.dart';

@immutable
class CustomState {}

class CustomInitState extends CustomState {}

class CustomLoadingState extends CustomState {}

class CustomLoadedState extends CustomState {}

class CustomEmptyState extends CustomState {}

class CustomErrorState extends CustomState {
  final String err;

  CustomErrorState(this.err);
}
