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
  Future<Either<Failure, AllUsersProfileModel>> getAllUsersProfiles(
      int page) async {
    try {
      UserAuthModel u = await SharedPreferencesHelper.getUserMode();
      var data = await apiService.getData(
          endPoint: 'users/?page=$page&limit=30',
          headers: {"Authorization": "Bearer ${u.data!.accessToken}"});
      return Right(AllUsersProfileModel.fromJson(data));
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure(e.response!.data.toString()));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserDataProfileModel>>> getAllUsersSearchProfiles(
      String key) async {
    try {
      UserAuthModel u = await SharedPreferencesHelper.getUserMode();

      var data = await apiService.getData(
          endPoint: 'users/searchUsers',
          body: {"searchKeyword": key},
          headers: {"Authorization": "Bearer ${u.data!.accessToken}"});
      List<dynamic> dd = data["data"];
      List<UserDataProfileModel> x = [];
      for (int i = 0; i < dd.length; i++) {
        x.add(UserDataProfileModel.fromJson(dd[i]));
      }
      return Right(x);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure(e.response!.data.toString()));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> deleteUser(
      String userId) async {
    try {
      UserAuthModel u = await SharedPreferencesHelper.getUserMode();

      var data = await apiService.deleteData(
          endPoint: 'users/$userId',
          headers: {"Authorization": "Bearer ${u.data!.accessToken}"},
          body: {});

      return Right(data);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure(e.response!.data.toString()));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> lockUSer(
      String userId, int days) async {
    try {
      UserAuthModel u = await SharedPreferencesHelper.getUserMode();

      var data = await apiService.putData(
          endPoint: 'users/$userId/locked',
          headers: {"Authorization": "Bearer ${u.data!.accessToken}"},
          body: {"lockedDays": days});

      return Right(data);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure(e.response!.data.toString()));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> unLockUSer(
      String userId) async {
    try {
      UserAuthModel u = await SharedPreferencesHelper.getUserMode();

      var data = await apiService.putData(
          endPoint: 'users/$userId/unlocked',
          headers: {"Authorization": "Bearer ${u.data!.accessToken}"},
          body: {});

      return Right(data);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure(e.response!.data.toString()));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserDataProfileModel>> getUser(String userId) async {
    try {
      UserAuthModel u = await SharedPreferencesHelper.getUserMode();

      var data = await apiService.getData(
          endPoint: 'users/$userId',
          headers: {"Authorization": "Bearer ${u.data!.accessToken}"});

      return Right(UserDataProfileModel.fromJson(data["data"]));
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure(e.response!.data.toString()));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
