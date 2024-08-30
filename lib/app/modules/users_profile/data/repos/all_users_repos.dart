import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../models/all_users_profile_model.dart';


abstract class AllUsersRepos {
  Future<Either<Failure, AllUsersProfileModel>> getAllUsersProfiles(int page);
  Future<Either<Failure, List<UserDataProfileModel>>> getAllUsersSearchProfiles(String key);
  Future<Either<Failure, Map<String,dynamic>>> deleteUser(String userId);
  Future<Either<Failure, Map<String,dynamic>>> lockUSer(String userId,int days);
  Future<Either<Failure, Map<String,dynamic>>> unLockUSer(String userId);
  Future<Either<Failure, UserDataProfileModel>> getUser(String userId);

}
