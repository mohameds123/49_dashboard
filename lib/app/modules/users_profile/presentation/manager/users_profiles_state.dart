abstract class UsersProfilesState {}

class AllUsersStateInitial extends UsersProfilesState {}

class GetAllUsersProfilesSuccessState extends UsersProfilesState {}
class GetAllUsersProfilesLoadingState extends UsersProfilesState {}
class GetAllUsersProfilesFailState extends UsersProfilesState {}


class GetAllUsersProfilesSearchSuccessState extends UsersProfilesState {}
class GetAllUsersProfilesSearchLoadingState extends UsersProfilesState {}
class GetAllUsersProfilesSearchFailState extends UsersProfilesState {}

class DeleteUserProfileSuccessState extends UsersProfilesState {}
class DeleteUserProfileLoadingState extends UsersProfilesState {}
class DeleteUserProfileFailState extends UsersProfilesState {}

class LockUserProfileSuccessState extends UsersProfilesState {}
class LockUserProfileLoadingState extends UsersProfilesState {}
class LockUserProfileFailState extends UsersProfilesState {}

class UnLockUserProfileSuccessState extends UsersProfilesState {}
class UnLockUserProfileLoadingState extends UsersProfilesState {}
class UnLockUserProfileFailState extends UsersProfilesState {}

class GetUserProfileSuccessState extends UsersProfilesState {}
class GetUserProfileLoadingState extends UsersProfilesState {}
class GetUserProfileFailState extends UsersProfilesState {}