import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../models/all_users_profile_model.dart';


abstract class AllUsersRepos {
  Future<Either<Failure, AllUsersProfileModel>> getAllUsersProfiles(int page);
  Future<Either<Failure, List<UserDataProfileModel>>> getAllUsersSearchProfiles(String key);

}
