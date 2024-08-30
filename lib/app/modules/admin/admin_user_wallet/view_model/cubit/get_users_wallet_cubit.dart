import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/user_wallet_model.dart';
import '../../data/repo/admin_user_wallet_repo.dart';
import 'get_users_model_state.dart';

class UsersWalletCubit extends Cubit<GetUsersWalletState> {
  UsersWalletCubit() : super(GetUsersWalletInitial());
  final AdminUserWalletRepo adminUserWalletRepo = AdminUserWalletRepo();

  Future<void> getUserWallet() async {
    emit(GetUsersWalletLoading());

    final result = await adminUserWalletRepo.getUserWallet();
    result.fold(
          (failure) => emit(GetUsersWalletError(error: failure.message!)),
          (data) {
        final userWallet = UserWalletDataModel.fromJson(data);
        emit(GetUsersWalletSuccess(userWalletModel: userWallet));
      },
    );
  }

  Future<void> updateUserAndWallet(String userId, UserWalletDataModel userWalletData) async {
    emit(GetUsersWalletLoading());

    final result = await adminUserWalletRepo.updateUserAndWallet(userId: userId, userWalletData: userWalletData);

    result.fold(
          (failure) => emit(GetUsersWalletError(error: failure.message!)),
          (data) => emit(GetUsersWalletSuccess(userWalletModel: UserWalletDataModel.fromJson(data))),
    );
  }
}
