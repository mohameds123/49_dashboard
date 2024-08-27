class AppManagerModel {
  double requestStorage;
  double callStorage;
  double anyStorage;
  double likeStorage;
  double viewStorage;
  double shareStorage;
  double requestPortion;
  double callPortion;
  double anyPortion;
  double likePortion;
  double viewPortion;
  double sharePortion;
  double welcomeGift;
  double referralGift;
  double freeClickGift;
  double stepValue;
  double maxDayGift;
  double tax;
  double vat;
  double totalGovernmentFees;
  double grossMoney;
  double totalOverHead;
  double overHeadConstant;
  double fortyNineStorage;
  double payMobCuts;
  double totalAmounts;
  double payMobConstant;
  double payMobPortion;
  double runningCost;
  double interest;
  bool rideCriminalRecord;
  bool rideDugAnalysis;
  bool rideTechnicalExamination;
  String rideTechnicalExaminationCenterLocation;
  String rideTechnicalExaminationCenterPhone;

  String rideDrugAnalysisCenterPhone;
  String rideDrugAnalysisCenterLocation;

  double giftPortion;
  double giftProviderPortion;
  double giftPaymentFactor;
  double rideAreaDistance;
  double rideRequestDuration;

  bool isMonthlyContestAvailable;
  double monthlyContestFees;
  double monthlyContestReward;
  String instantPayNumber;

  AppManagerModel({
    required this.requestStorage,
    required this.callStorage,
    required this.anyStorage,
    required this.likeStorage,
    required this.viewStorage,
    required this.shareStorage,
    required this.requestPortion,
    required this.callPortion,
    required this.anyPortion,
    required this.likePortion,
    required this.viewPortion,
    required this.sharePortion,
    required this.welcomeGift,
    required this.referralGift,
    required this.freeClickGift,
    required this.stepValue,
    required this.maxDayGift,
    required this.tax,
    required this.vat,
    required this.totalGovernmentFees,
    required this.grossMoney,
    required this.totalOverHead,
    required this.overHeadConstant,
    required this.fortyNineStorage,
    required this.payMobCuts,
    required this.totalAmounts,
    required this.payMobConstant,
    required this.payMobPortion,
    required this.runningCost,
    required this.interest,
    required this.rideCriminalRecord,
    required this.rideDugAnalysis,
    required this.rideTechnicalExamination,
    required this.rideTechnicalExaminationCenterLocation,
    required this.rideTechnicalExaminationCenterPhone,
    required this.rideDrugAnalysisCenterPhone,
    required this.rideDrugAnalysisCenterLocation,
    required this.giftPaymentFactor,
    required this.giftPortion,
    required this.giftProviderPortion,
    required this.rideAreaDistance,
    required this.rideRequestDuration,
    required this.monthlyContestFees,
    required this.isMonthlyContestAvailable,
    required this.monthlyContestReward,
    required this.instantPayNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'request_storage': this.requestStorage,
      'call_storage': this.callStorage,
      'any_storage': this.anyStorage,
      'like_storage': this.likeStorage,
      'view_storage': this.viewStorage,
      'share_storage': this.shareStorage,
      'request_portion': this.requestPortion,
      'call_portion': this.callPortion,
      'any_portion': this.anyPortion,
      'like_portion': this.likePortion,
      'view_portion': this.viewPortion,
      'share_portion': this.sharePortion,
      'welcome_gift': this.welcomeGift,
      'referral_gift': this.referralGift,
      'free_click_gift': this.freeClickGift,
      'step_value': this.stepValue,
      'max_day_gift': this.maxDayGift,
      'tax': this.tax,
      'vat': this.vat,
      'total_government_fees': this.totalGovernmentFees,
      'gross_money': this.grossMoney,
      'total_over_head': this.totalOverHead,
      'over_head_constant': this.overHeadConstant,
      'forty_nine_storage': this.fortyNineStorage,
      'pay_mob_cuts': this.payMobCuts,
      'total_amounts': this.totalAmounts,
      'pay_mob_constant': this.payMobConstant,
      'pay_mob_portion': this.payMobPortion,
      'running_cost': this.runningCost,
      'interest': this.interest,
      'ride_criminal_record': this.rideCriminalRecord,
      'ride_drug_analysis': this.rideDugAnalysis,
      'ride_technical_examination': this.rideTechnicalExamination,
      'ride_technical_examination_center_location':
          this.rideTechnicalExaminationCenterLocation,
      'ride_technical_examination_center_phone':
          this.rideTechnicalExaminationCenterPhone,
      'ride_drug_analysis_center_phone': this.rideDrugAnalysisCenterPhone,
      'ride_drug_analysis_center_location': this.rideDrugAnalysisCenterLocation,
      'gift_portion': this.giftPortion,
      'gift_provider_portion': this.giftProviderPortion,
      'gift_payment_factor': this.giftPaymentFactor,
      'ride_area_distance': this.rideAreaDistance,
      'ride_request_duration': this.rideRequestDuration,
      'is_monthly_contest_available': this.isMonthlyContestAvailable,
      'monthly_contest_fees': this.monthlyContestFees,
      'monthly_contest_reward': this.monthlyContestReward,
      'instant_pay_number': this.instantPayNumber,
    };
  }

  factory AppManagerModel.fromMap(Map<String, dynamic> map) {
    return AppManagerModel(
      requestStorage: double.parse(map['request_storage'].toString()),
      callStorage: double.parse(map['call_storage'].toString()),
      anyStorage: double.parse(map['any_storage'].toString()),
      likeStorage: double.parse(map['like_storage'].toString()),
      viewStorage: double.parse(map['view_storage'].toString()),
      shareStorage: double.parse(map['share_storage'].toString()),
      requestPortion: double.parse(map['request_portion'].toString()),
      callPortion: double.parse(map['call_portion'].toString()),
      anyPortion: double.parse(map['any_portion'].toString()),
      likePortion: double.parse(map['like_portion'].toString()),
      viewPortion: double.parse(map['view_portion'].toString()),
      sharePortion: double.parse(map['share_portion'].toString()),
      welcomeGift: double.parse(map['welcome_gift'].toString()),
      referralGift: double.parse(map['referral_gift'].toString()),
      freeClickGift: double.parse(map['free_click_gift'].toString()),
      stepValue: double.parse(map['step_value'].toString()),
      maxDayGift: double.parse(map['max_day_gift'].toString()),
      tax: double.parse(map['tax'].toString()),
      vat: double.parse(map['vat'].toString()),
      totalGovernmentFees:
          double.parse(map['total_government_fees'].toString()),
      grossMoney: double.parse(map['gross_money'].toString()),
      totalOverHead: double.parse(map['total_over_head'].toString()),
      overHeadConstant: double.parse(map['over_head_constant'].toString()),
      fortyNineStorage: double.parse(map['forty_nine_storage'].toString()),
      payMobCuts: double.parse(map['pay_mob_cuts'].toString()),
      totalAmounts: double.parse(map['total_amounts'].toString()),
      payMobConstant: double.parse(map['pay_mob_constant'].toString()),
      payMobPortion: double.parse(map['pay_mob_portion'].toString()),
      runningCost: double.parse(map['running_cost'].toString()),
      interest: double.parse(map['interest'].toString()),
      rideCriminalRecord: map['ride_criminal_record'] as bool,
      rideDugAnalysis: map['ride_drug_analysis'] as bool,
      rideTechnicalExamination: map['ride_technical_examination'] as bool,
      rideTechnicalExaminationCenterLocation:
          map['ride_technical_examination_center_location'] as String? ?? '',
      rideTechnicalExaminationCenterPhone:
          map['ride_technical_examination_center_phone'] as String? ?? '',
      rideDrugAnalysisCenterPhone:
          map['ride_drug_analysis_center_phone'] as String? ?? '',
      rideDrugAnalysisCenterLocation:
          map['ride_drug_analysis_center_location'] as String? ?? '',
      giftPortion: double.parse(map['gift_portion'].toString()),
      giftProviderPortion:
          double.parse(map['gift_provider_portion'].toString()),
      giftPaymentFactor: double.parse(map['gift_payment_factor'].toString()),
      rideAreaDistance: double.parse(map['ride_area_distance'].toString()),
      rideRequestDuration:
          double.parse(map['ride_request_duration'].toString()),
      isMonthlyContestAvailable:
          map['is_monthly_contest_available'] as bool? ?? false,
      monthlyContestReward: map['monthly_contest_reward'] == null
          ? 0
          : double.parse(map['monthly_contest_reward'].toString()),
      monthlyContestFees: map['monthly_contest_fees'] == null
          ? 0
          : double.parse(map['monthly_contest_fees'].toString()),
      instantPayNumber: map['instant_pay_number'] as String? ?? '',
    );
  }
}
