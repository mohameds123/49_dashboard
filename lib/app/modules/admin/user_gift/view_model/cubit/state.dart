
import '../../data/model/model.dart';

abstract class GetUsersGiftsState {}

class GetUsersGiftsInitial extends GetUsersGiftsState {}

class GetUsersGiftsLoading extends GetUsersGiftsState {}

class GetUsersGiftsSuccess extends GetUsersGiftsState {
  final UserGitDataList userGitDataList;

  GetUsersGiftsSuccess({required this.userGitDataList});
}

class GetUsersGiftsError extends GetUsersGiftsState {
  final String error;

  GetUsersGiftsError({required this.error});
}
