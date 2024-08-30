

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fourtynine_dashboard/app/modules/admin/user_gift/view_model/cubit/state.dart';

import '../../data/model/model.dart';
import '../../data/repo/repo.dart';

class GetUsersGiftsCubit extends Cubit<GetUsersGiftsState> {
  final AdminUserGift adminUserGift;

  GetUsersGiftsCubit({required this.adminUserGift}) : super(GetUsersGiftsInitial());

  Future<void> fetchUserGifts() async {
    try {
      emit(GetUsersGiftsLoading());

      final result = await adminUserGift.getUserWallet();

      result.fold(
            (failure) => emit(GetUsersGiftsError(error: failure.message!)),
            (data) {
          final userGiftDataList = UserGitDataList.fromJson(data);
          emit(GetUsersGiftsSuccess(userGitDataList: userGiftDataList));
        },
      );
    } catch (e) {
      emit(GetUsersGiftsError(error: e.toString()));
    }
  }
  void sortGiftsAscending() {
    if (state is GetUsersGiftsSuccess) {
      final currentState = state as GetUsersGiftsSuccess;
      final sortedList = currentState.userGitDataList.data!
        ..sort((a, b) => (a.totalGifts ?? 0).compareTo(b.totalGifts ?? 0));
      emit(GetUsersGiftsSuccess(userGitDataList: currentState.userGitDataList.copyWith(data: sortedList)));
    }
  }

  void sortGiftsDescending() {
    if (state is GetUsersGiftsSuccess) {
      final currentState = state as GetUsersGiftsSuccess;
      final sortedList = currentState.userGitDataList.data!
        ..sort((a, b) => (b.totalGifts ?? 0).compareTo(a.totalGifts ?? 0));
      emit(GetUsersGiftsSuccess(userGitDataList: currentState.userGitDataList.copyWith(data: sortedList)));
    }
  }
}
