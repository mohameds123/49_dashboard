class UserGitDataList {
  bool? status;
  List<UserGiftDataModel>? data;

  UserGitDataList({this.status, this.data});
  UserGitDataList copyWith({bool? status, List<UserGiftDataModel>? data}) {
    return UserGitDataList(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }
  UserGitDataList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <UserGiftDataModel>[];
      json['data'].forEach((v) {
        data!.add(new UserGiftDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserGiftDataModel {
  String? sId;
  String? firstName;
  String? lastName;
  int? totalGifts;
  List<CompetitionsWallets>? competitionsWallets;
  int? wheelGifts;
  String? id;

  UserGiftDataModel(
      {this.sId,
        this.firstName,
        this.lastName,
        this.totalGifts,
        this.competitionsWallets,
        this.wheelGifts,
        this.id});

  UserGiftDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    totalGifts = json['totalGifts'];
    if (json['competitionsWallets'] != null) {
      competitionsWallets = <CompetitionsWallets>[];
      json['competitionsWallets'].forEach((v) {
        competitionsWallets!.add(new CompetitionsWallets.fromJson(v));
      });
    }
    wheelGifts = json['WheelGifts'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['totalGifts'] = this.totalGifts;
    if (this.competitionsWallets != null) {
      data['competitionsWallets'] =
          this.competitionsWallets!.map((v) => v.toJson()).toList();
    }
    data['WheelGifts'] = this.wheelGifts;
    data['id'] = this.id;
    return data;
  }
}

class CompetitionsWallets {
  String? sId;
  CompetitionId? competitionId;
  String? userId;
  int? amount;

  CompetitionsWallets({this.sId, this.competitionId, this.userId, this.amount});

  CompetitionsWallets.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    competitionId = json['competition_id'] != null
        ? new CompetitionId.fromJson(json['competition_id'])
        : null;
    userId = json['user_id'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.competitionId != null) {
      data['competition_id'] = this.competitionId!.toJson();
    }
    data['user_id'] = this.userId;
    data['amount'] = this.amount;
    return data;
  }
}

class CompetitionId {
  String? sId;
  String? nameAr;
  String? nameEn;

  CompetitionId({this.sId, this.nameAr, this.nameEn});

  CompetitionId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    nameAr = json['nameAr'];
    nameEn = json['nameEn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['nameAr'] = this.nameAr;
    data['nameEn'] = this.nameEn;
    return data;
  }
}