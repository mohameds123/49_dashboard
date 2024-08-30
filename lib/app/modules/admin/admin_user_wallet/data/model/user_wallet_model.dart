class UserWalletDataModel {
  bool status;
  List<Data> data;

  UserWalletDataModel({
    required this.status,
    required this.data,
  });

  factory UserWalletDataModel.fromJson(Map<String, dynamic> json) {
    return UserWalletDataModel(
      status: json['status'],
      data: List<Data>.from(json['data'].map((item) => Data.fromJson(item))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': List<dynamic>.from(data.map((item) => item.toJson())),
    };
  }
}

class Data {
  String id;
  UserId? userId;
  double balance;
  double grossMoney;
  double monthlyBalance;
  int total;
  int months;
  int tenYears;
  int fiveYears;
  double providerCashBack;
  int refundStorage;
  int freeClickStorage;
  int referralStorage;
  int referralCashBack;
  double shareBalance;
  int totalPayment;
  int totalCashBack;
  int todayGift;
  String lastGift;
  int totalLikes;
  int totalViews;
  int totalShares;
  bool isActive;
  double realAmount;
  String createdAt;
  String updatedAt;
  int referralCount;
  int uniqueReferralCount;
  int? todayLikes; // New field
  int? todayShares; // New field
  int? todayViews; // New field
  int? s; // New field

  Data({
    required this.id,
    this.userId,
    required this.balance,
    required this.grossMoney,
    required this.monthlyBalance,
    required this.total,
    required this.months,
    required this.tenYears,
    required this.fiveYears,
    required this.providerCashBack,
    required this.refundStorage,
    required this.freeClickStorage,
    required this.referralStorage,
    required this.referralCashBack,
    required this.shareBalance,
    required this.totalPayment,
    required this.totalCashBack,
    required this.todayGift,
    required this.lastGift,
    required this.totalLikes,
    required this.totalViews,
    required this.totalShares,
    required this.isActive,
    required this.realAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.referralCount,
    required this.uniqueReferralCount,
    this.todayLikes,
    this.todayShares,
    this.todayViews,
    this.s,
  });
  Data copyWith({
    String? id,
    UserId? userId,
    double? balance,
    double? grossMoney,
    double? monthlyBalance,
    int? total,
    int? months,
    int? tenYears,
    int? fiveYears,
    double? providerCashBack,
    int? refundStorage,
    int? freeClickStorage,
    int? referralStorage,
    int? referralCashBack,
    double? shareBalance,
    int? totalPayment,
    int? totalCashBack,
    int? todayGift,
    String? lastGift,
    int? totalLikes,
    int? totalViews,
    int? totalShares,
    bool? isActive,
    double? realAmount,
    String? createdAt,
    String? updatedAt,
    int? referralCount,
    int? uniqueReferralCount,
    int? todayLikes,
    int? todayShares,
    int? todayViews,
    int? s,
  }) {
    return Data(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      balance: balance ?? this.balance,
      grossMoney: grossMoney ?? this.grossMoney,
      monthlyBalance: monthlyBalance ?? this.monthlyBalance,
      total: total ?? this.total,
      months: months ?? this.months,
      tenYears: tenYears ?? this.tenYears,
      fiveYears: fiveYears ?? this.fiveYears,
      providerCashBack: providerCashBack ?? this.providerCashBack,
      refundStorage: refundStorage ?? this.refundStorage,
      freeClickStorage: freeClickStorage ?? this.freeClickStorage,
      referralStorage: referralStorage ?? this.referralStorage,
      referralCashBack: referralCashBack ?? this.referralCashBack,
      shareBalance: shareBalance ?? this.shareBalance,
      totalPayment: totalPayment ?? this.totalPayment,
      totalCashBack: totalCashBack ?? this.totalCashBack,
      todayGift: todayGift ?? this.todayGift,
      lastGift: lastGift ?? this.lastGift,
      totalLikes: totalLikes ?? this.totalLikes,
      totalViews: totalViews ?? this.totalViews,
      totalShares: totalShares ?? this.totalShares,
      isActive: isActive ?? this.isActive,
      realAmount: realAmount ?? this.realAmount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      referralCount: referralCount ?? this.referralCount,
      uniqueReferralCount: uniqueReferralCount ?? this.uniqueReferralCount,
      todayLikes: todayLikes ?? this.todayLikes,
      todayShares: todayShares ?? this.todayShares,
      todayViews: todayViews ?? this.todayViews,
      s: s ?? this.s,
    );
  }
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['_id'],
      userId: json['user_id'] != null ? UserId.fromJson(json['user_id']) : null,
      balance: (json['balance'] as num).toDouble(),
      grossMoney: (json['gross_money'] as num).toDouble(),
      monthlyBalance: (json['monthly_balance'] as num).toDouble(),
      total: json['total'],
      months: json['months'],
      tenYears: json['ten_years'],
      fiveYears: json['five_years'],
      providerCashBack: (json['provider_cash_back'] as num).toDouble(),
      refundStorage: json['refund_storage'],
      freeClickStorage: json['free_click_storage'],
      referralStorage: json['referral_storage'],
      referralCashBack: json['referral_cash_back'],
      shareBalance: (json['shareBalance'] as num).toDouble(),
      totalPayment: json['total_payment'],
      totalCashBack: json['total_cash_back'],
      todayGift: json['today_gift'],
      lastGift: json['last_gift'],
      totalLikes: json['total_likes'],
      totalViews: json['total_views'],
      totalShares: json['total_shares'],
      isActive: json['isActive'],
      realAmount: (json['realAmount'] as num).toDouble(),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      referralCount: json['referralCount'],
      uniqueReferralCount: json['uniqueReferralCount'],
      todayLikes: json['today_likes'],
      todayShares: json['today_shares'],
      todayViews: json['today_views'],
      s: json['s'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user_id': userId?.toJson(),
      'balance': balance,
      'gross_money': grossMoney,
      'monthly_balance': monthlyBalance,
      'total': total,
      'months': months,
      'ten_years': tenYears,
      'five_years': fiveYears,
      'provider_cash_back': providerCashBack,
      'refund_storage': refundStorage,
      'free_click_storage': freeClickStorage,
      'referral_storage': referralStorage,
      'referral_cash_back': referralCashBack,
      'shareBalance': shareBalance,
      'total_payment': totalPayment,
      'total_cash_back': totalCashBack,
      'today_gift': todayGift,
      'last_gift': lastGift,
      'total_likes': totalLikes,
      'total_views': totalViews,
      'total_shares': totalShares,
      'isActive': isActive,
      'realAmount': realAmount,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'referralCount': referralCount,
      'uniqueReferralCount': uniqueReferralCount,
      'today_likes': todayLikes,
      'today_shares': todayShares,
      'today_views': todayViews,
      's': s,
    };
  }
}

class UserId {
  String id;
  String firstName;
  String lastName;

  UserId({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
