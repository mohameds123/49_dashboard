import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fourtynine_dashboard/app/core/errors/errors.dart';
import 'package:fourtynine_dashboard/app/modules/users_profile/data/models/all_users_profile_model.dart';

import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/shared_pref_helper.dart';
import '../models/user_auth_model.dart';
import 'all_users_repos.dart';

class AllUsersReposImpl implements AllUsersRepos {
  ApiService apiService;
  AllUsersReposImpl(this.apiService);

  @override
  Future<Either<Failure, AllUsersProfileModel>> getAllUsersProfiles(int page) async {
    try {
      UserAuthModel u = await SharedPreferencesHelper.getUserMode();
      var data = await apiService.getData(
          endPoint: 'users/?page=$page&limit=10',
          headers: {"Authorization": "Bearer ${u.data!.accessToken}"});
      return Right(AllUsersProfileModel.fromJson(data));
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure(e.response!.data.toString()));
      }
      return left(ServerFailure(e.toString()));
    }
  }


}
