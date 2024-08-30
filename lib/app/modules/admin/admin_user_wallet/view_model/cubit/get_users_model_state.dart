import '../../data/model/user_wallet_model.dart';

abstract class GetUsersWalletState {}

class GetUsersWalletInitial extends GetUsersWalletState {}

class GetUsersWalletLoading extends GetUsersWalletState {}

class GetUsersWalletSuccess extends GetUsersWalletState {
  final UserWalletDataModel userWalletModel;

  GetUsersWalletSuccess({required this.userWalletModel});
}

class GetUsersWalletError extends GetUsersWalletState {
  final String error;

  GetUsersWalletError({required this.error});
}
class UpdateUsersWalletLoading extends GetUsersWalletState {}

class UpdateUsersWalletSuccess extends GetUsersWalletState {
  final UserWalletDataModel userWalletModel;

  UpdateUsersWalletSuccess({required this.userWalletModel});
}

class UpdateUsersWalletError extends GetUsersWalletState {
  final String error;

  UpdateUsersWalletError({required this.error});
}
