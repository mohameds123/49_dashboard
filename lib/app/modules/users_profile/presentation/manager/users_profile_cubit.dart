import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fourtynine_dashboard/app/modules/users_profile/data/models/all_users_profile_model.dart';
import 'package:fourtynine_dashboard/app/modules/users_profile/data/repos/all_users_repos.dart';
import 'package:fourtynine_dashboard/app/modules/users_profile/presentation/manager/users_profiles_state.dart';

class AllUsersCubit extends Cubit<UsersProfilesState> {
  AllUsersCubit(this.allUsersRepos) : super(AllUsersStateInitial());
  AllUsersRepos allUsersRepos;

  static AllUsersCubit get(context) => BlocProvider.of(context);

  AllUsersProfileModel? allUsersProfileModel;

  Future<void> getAllUsersProfiles({int? page}) async {
    emit(GetAllUsersProfilesLoadingState());
    var result = await allUsersRepos.getAllUsersProfiles(page!);

    result.fold((fail) {
      log(fail.errMessage);
      allUsersProfileModel = null;
      emit(GetAllUsersProfilesFailState());
    }, (data) {
      allUsersProfileModel = data;
      log(data.toString());
      emit(GetAllUsersProfilesSuccessState());
    });
  }

  List<UserDataProfileModel> searchResult = [];

  Future<void> getUsersSearchProfiles({String? key}) async {
    emit(GetAllUsersProfilesSearchLoadingState());
    var result = await allUsersRepos.getAllUsersSearchProfiles(key!);
    result.fold((fail) {
      log(fail.errMessage);
      emit(GetAllUsersProfilesSearchFailState());
    }, (data) {
      searchResult = data;
      log(data.toString());
      emit(GetAllUsersProfilesSearchSuccessState());
    });
  }

  UserDataProfileModel? selectedUserDataProfileModel;

  Future<void> deleteUserProfile({String? userId}) async {
    emit(DeleteUserProfileLoadingState());
    var result = await allUsersRepos.deleteUser(userId!);
    result.fold((fail) {
      log(fail.errMessage);
      emit(DeleteUserProfileFailState());
    }, (data) {
      emit(DeleteUserProfileSuccessState());
    });
  }

  Future<void> lockUserProfile({String? userId, int? days}) async {
    emit(LockUserProfileLoadingState());
    var result = await allUsersRepos.lockUSer(userId!, days!);
    result.fold((fail) {
      log(fail.errMessage);
      emit(LockUserProfileFailState());
    }, (data) {
      emit(LockUserProfileSuccessState());
    });
  }

  Future<void> unLockUserProfile({String? userId}) async {
    emit(UnLockUserProfileLoadingState());
    var result = await allUsersRepos.unLockUSer(userId!);
    result.fold((fail) {
      log(fail.errMessage);
      emit(UnLockUserProfileFailState());
    }, (data) {
      emit(UnLockUserProfileSuccessState());
    });
  }

  Future<void> getUserProfile({String? userId}) async {
    emit(GetUserProfileLoadingState());
    var result = await allUsersRepos.getUser(userId!);
    result.fold((fail) {
      log(fail.errMessage);
      emit(GetUserProfileFailState());
    }, (data) {
      selectedUserDataProfileModel = data;
      emit(GetUserProfileSuccessState());
    });
  }
}
