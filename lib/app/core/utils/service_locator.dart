import 'package:dio/dio.dart';
import 'package:fourtynine_dashboard/app/modules/users_profile/data/repos/all_users_repos.dart';
import 'package:get_it/get_it.dart';

import '../../modules/users_profile/data/repos/all_users_repos_impl.dart';
import 'api_service.dart';


final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));

  getIt.registerSingleton<AllUsersRepos>(AllUsersReposImpl(getIt.get<ApiService>()));

}
