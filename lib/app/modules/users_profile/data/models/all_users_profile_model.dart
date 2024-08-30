
class AllUsersProfileModel {
  bool? status;
  List<UserDataProfileModel>? data;

  AllUsersProfileModel({this.status, this.data});

  AllUsersProfileModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data = json["data"] == null ? null : (json["data"] as List).map((e) => UserDataProfileModel.fromJson(e)).toList();
  }

  static List<AllUsersProfileModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => AllUsersProfileModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    if(data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class UserDataProfileModel {
  Location? location;
  var followingCount;
  var friendsCount;
  String? socketId;
  String? firstName;
  String? lastName;
  String? email;
  dynamic birthday;
  String? hashedPassword;
  String? gender;
  bool? adminIgnore;
  List<dynamic>? following;
  List<dynamic>? blockedUsers;
  List<dynamic>? hiddenPosts;
  List<dynamic>? followers;
  String? referralId;
  bool? isLocked;
  dynamic lockedDate;
  bool? isRider;
  bool? isDoctor;
  bool? isRestaurant;
  bool? isLoading;
  String? language;
  bool? isEmailVerified;
  bool? isPhoneVerified;
  bool? isDeleted;
  String? countryCode;
  List<dynamic>? auctionUsers;
  List<dynamic>? installmentsUsers;
  bool? twitterDocumentation;
  String? username;
  String? createdAt;
  String? updatedAt;
  String? chatPassword;
  String? phone;
  String? referralUser;
  var followersCount;
  UserProfile? userProfile;
  String? id;

  UserDataProfileModel({this.location, this.followingCount, this.friendsCount, this.id, this.socketId, this.firstName, this.lastName, this.email, this.birthday, this.hashedPassword, this.gender, this.adminIgnore, this.following, this.blockedUsers, this.hiddenPosts, this.followers, this.referralId, this.isLocked, this.lockedDate, this.isRider, this.isDoctor, this.isRestaurant, this.isLoading, this.language, this.isEmailVerified, this.isPhoneVerified, this.isDeleted, this.countryCode, this.auctionUsers, this.installmentsUsers, this.twitterDocumentation, this.username, this.createdAt, this.updatedAt, this.chatPassword, this.phone, this.referralUser, this.followersCount, this.userProfile});

  UserDataProfileModel.fromJson(Map<String, dynamic> json) {
    location = json["location"] == null ? null : Location.fromJson(json["location"]);
    followingCount = json["followingCount"];
    friendsCount = json["friendsCount"];
    id = json["_id"];
    socketId = json["socketId"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    email = json["email"];
    birthday = json["birthday"];
    hashedPassword = json["hashedPassword"];
    gender = json["gender"];
    adminIgnore = json["adminIgnore"];
    following = json["following"] ?? [];
    blockedUsers = json["blockedUsers"] ?? [];
    hiddenPosts = json["hiddenPosts"] ?? [];
    followers = json["followers"] ?? [];
    referralId = json["referralId"];
    isLocked = json["isLocked"];
    lockedDate = json["lockedDate"];
    isRider = json["isRider"];
    isDoctor = json["isDoctor"];
    isRestaurant = json["isRestaurant"];
    isLoading = json["isLoading"];
    language = json["language"];
    isEmailVerified = json["isEmailVerified"];
    isPhoneVerified = json["isPhoneVerified"];
    isDeleted = json["isDeleted"];
    countryCode = json["countryCode"];
    auctionUsers = json["auction_users"] ?? [];
    installmentsUsers = json["installments_users"] ?? [];
    twitterDocumentation = json["twitter_documentation"];
    username = json["username"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    chatPassword = json["chatPassword"];
    phone = json["phone"];
    referralUser = json["referralUser"];
    followersCount = json["followersCount"];
    userProfile = json["USER_PROFILE"] == null ? null : UserProfile.fromJson(json["USER_PROFILE"]);
    id = json["id"];
  }

  static List<UserDataProfileModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => UserDataProfileModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(location != null) {
      _data["location"] = location?.toJson();
    }
    _data["followingCount"] = followingCount;
    _data["friendsCount"] = friendsCount;
    _data["_id"] = id;
    _data["socketId"] = socketId;
    _data["firstName"] = firstName;
    _data["lastName"] = lastName;
    _data["email"] = email;
    _data["birthday"] = birthday;
    _data["hashedPassword"] = hashedPassword;
    _data["gender"] = gender;
    _data["adminIgnore"] = adminIgnore;
    if(following != null) {
      _data["following"] = following;
    }
    if(blockedUsers != null) {
      _data["blockedUsers"] = blockedUsers;
    }
    if(hiddenPosts != null) {
      _data["hiddenPosts"] = hiddenPosts;
    }
    if(followers != null) {
      _data["followers"] = followers;
    }
    _data["referralId"] = referralId;
    _data["isLocked"] = isLocked;
    _data["lockedDate"] = lockedDate;
    _data["isRider"] = isRider;
    _data["isDoctor"] = isDoctor;
    _data["isRestaurant"] = isRestaurant;
    _data["isLoading"] = isLoading;
    _data["language"] = language;
    _data["isEmailVerified"] = isEmailVerified;
    _data["isPhoneVerified"] = isPhoneVerified;
    _data["isDeleted"] = isDeleted;
    _data["countryCode"] = countryCode;
    if(auctionUsers != null) {
      _data["auction_users"] = auctionUsers;
    }
    if(installmentsUsers != null) {
      _data["installments_users"] = installmentsUsers;
    }
    _data["twitter_documentation"] = twitterDocumentation;
    _data["username"] = username;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["chatPassword"] = chatPassword;
    _data["phone"] = phone;
    _data["referralUser"] = referralUser;
    _data["followersCount"] = followersCount;
    if(userProfile != null) {
      _data["USER_PROFILE"] = userProfile?.toJson();
    }
    _data["id"] = id;
    return _data;
  }
}

class UserProfile {
  String? id;
  String? userId;
  ProfilePictureKey? profilePictureKey;

  UserProfile({this.id, this.userId, this.profilePictureKey});

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    userId = json["userId"];
    profilePictureKey = json["profilePictureKey"] == null ? null : ProfilePictureKey.fromJson(json["profilePictureKey"]);
  }

  static List<UserProfile> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => UserProfile.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["userId"] = userId;
    if(profilePictureKey != null) {
      _data["profilePictureKey"] = profilePictureKey?.toJson();
    }
    return _data;
  }
}

class ProfilePictureKey {
  String? id;
  String? mediaKey;

  ProfilePictureKey({this.id, this.mediaKey});

  ProfilePictureKey.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    mediaKey = json["mediaKey"];
  }

  static List<ProfilePictureKey> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => ProfilePictureKey.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["mediaKey"] = mediaKey;
    return _data;
  }
}

class Location {
  String? type;
  List<dynamic>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    coordinates = json["coordinates"] == null ? null : List<dynamic>.from(json["coordinates"]);
  }

  static List<Location> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Location.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["type"] = type;
    if(coordinates != null) {
      _data["coordinates"] = coordinates;
    }
    return _data;
  }
}