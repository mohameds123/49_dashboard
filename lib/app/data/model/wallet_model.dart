import '../../core/helper/date.dart';

class WalletModel {
  final String userId;
   double balance;
   double startBalance;
   double balanceAfterFive;
   double grossMoney;
   double profit;
   double? tenYears;
   double? fiveYears;
   double providerCasBack;
   double refundStorage;
   double freeClickStorage;
   double referralStorage;
   double referralCashBack;
   double totalCashBack;
   double totalPayment;
   int todayGift;
   String lastGift;
   int totalLikes;
   int totalViews;
   int totalShares;
   int months;
   double monthlyBalance;

  final DateTime createdAt;

  WalletModel({
    required this.userId,
    required this.balance,
    required this.startBalance,
    required this.balanceAfterFive,
    required this.grossMoney,
    required this.profit,
    this.tenYears,
    this.fiveYears,
    required this.providerCasBack,
    required this.refundStorage,
    required this.freeClickStorage,
    required this.referralStorage,
    required this.referralCashBack,
    required this.totalCashBack,
    required this.todayGift,
    required this.lastGift,
    required this.totalPayment,
    required this.totalLikes,
    required this.totalViews,
    required this.totalShares,
    required this.months,
    required this.monthlyBalance,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'balance': balance,
      'start_balance': startBalance,
      'balance_after_five': balanceAfterFive,
      'gross_money': grossMoney,
      'profit': profit,
      'ten_years': tenYears,
      'five_years': fiveYears,
      'provider_cash_back': providerCasBack,
      'refund_storage': refundStorage,
      'free_click_storage': freeClickStorage,
      'referral_storage': referralStorage,
      'referral_cash_back': referralCashBack,
      'total_payment': totalPayment,
      'total_cash_back': totalCashBack,
      'today_gift': todayGift,
      'last_gift': lastGift,
      'total_likes': totalLikes,
      'total_views': totalViews,
      'total_shares': totalShares,
      'months': months,
      'monthly_balance': monthlyBalance,
    };
  }

  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      userId: map['user_id'] as String,
      balance: double.parse(map['balance'].toString()),
      startBalance: double.tryParse(map['start_balance'].toString()) ?? 0,
      balanceAfterFive: double.tryParse(map['balance_after_five'].toString()) ?? 0,
      grossMoney: double.tryParse(map['gross_money'].toString()) ?? 0,
      profit: double.tryParse(map['profit'].toString()) ?? 0,
      tenYears: double.tryParse(map['ten_years'].toString()),
      fiveYears: double.tryParse(map['five_years'].toString()),
      providerCasBack: double.tryParse(map['provider_cash_back'].toString()) ?? 0,
      refundStorage: double.tryParse(map['refund_storage'].toString()) ?? 0,
      freeClickStorage: double.tryParse(map['free_click_storage'].toString()) ?? 0,
      referralStorage: double.tryParse(map['referral_storage'].toString()) ?? 0,
      referralCashBack: double.tryParse(map['referral_cash_back'].toString()) ?? 0,
      totalCashBack: double.tryParse(map['total_cash_back'].toString()) ?? 0,
      totalPayment: double.tryParse(map['total_payment'].toString()) ?? 0,
      todayGift: map['today_gift'] as int,
      lastGift: map['last_gift'] as String,
      totalLikes: map['total_likes'] as int,
      totalViews: map['total_views'] as int,
      totalShares: map['total_shares'] as int,
      months: map['months'] as int,
      monthlyBalance: double.tryParse(map['monthly_balance'].toString()) ?? 0,
      createdAt: (map['createdAt'] as String).toDate(),
    );
  }
}
