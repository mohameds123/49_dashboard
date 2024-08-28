import 'dart:developer';

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
          endPoint: 'users/?page=$page&limit=48',
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
          headers: {"Authorization": "Bearer ${u.data!.accessToken}"}
      );

      // Ensure `data["data"]` is a list
      List<dynamic> dd = data["data"];

      // Initialize a list to store the parsed user profiles
      List<UserDataProfileModel> x = [];

      // Parse each item in the list
      for (int i = 0; i < dd.length; i++) {
        // Log each item being parsed for debugging
        print("Data $i: ${dd[i].toString()}");

        // Convert each item to a UserDataProfileModel and add to the list
        x.add(UserDataProfileModel.fromJson(dd[i]));
      }

      // Optionally log the list of parsed user profiles
      log(x.toString());

      // Return the list wrapped in a `Right` object
      return Right(x);
    }
    catch (e) {
      if (e is DioError) {
        return left(ServerFailure(e.response!.data.toString()));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
