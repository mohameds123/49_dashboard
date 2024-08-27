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
      emit(GetAllUsersProfilesFailState());
    }, (data) {
      allUsersProfileModel = data;
      log(data.toString());
      emit(GetAllUsersProfilesSuccessState());
    });
  }
}
