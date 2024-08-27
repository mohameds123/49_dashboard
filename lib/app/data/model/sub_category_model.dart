import '../../core/constants.dart';
import 'dynamic/dynamic_prop_model.dart';

class SubCategoryModel {
  final String id;

  int index;
  int? newIndex;

  String nameAr;
  String nameEn;

  String parent;
  String picture;

  double totalOverHead;
  double grossMoney;
  double overHeadFactor;

  bool isHidden;
  double dailyPrice;
  double portion;
  double providerPortion;
  double paymentFactor;

  String? picturePath;

  List<DynamicPropModel> props;

  SubCategoryModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.isHidden,
    required this.dailyPrice,
    required this.portion,
    required this.providerPortion,
    required this.paymentFactor,
    required this.totalOverHead,
    required this.picture,
    required this.parent,
    required this.index,
    required this.overHeadFactor,
    required this.grossMoney,
    required this.props,
  });

  Map<String, dynamic> toMap() {
    return {
      'name_ar': this.nameAr,
      'name_en': this.nameEn,
      'is_hidden': this.isHidden,
      'daily_price': this.dailyPrice,
      'portion': this.portion,
      'provider_portion': this.providerPortion,
      'payment_factor': this.paymentFactor,
      'gross_money': this.grossMoney,
      'picture': this.picture.replaceFirst(AppConstants.imageBaseUrl, ''),
      'parent': this.parent,
      'index': this.index,
      'total_over_head': this.totalOverHead,
      'over_head_factor': this.overHeadFactor,
    };
  }

  Map<String, dynamic> toBriefMap() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
      'picture': picture,
    };
  }

  factory SubCategoryModel.fromMap(Map<String, dynamic> map) {
    final List<DynamicPropModel> props = map['props'] == null
        ? []
        : (map['props'] as List)
            .map((e) => DynamicPropModel.fromMap(e))
            .toList();
    props.sort((a, b) => a.index.compareTo(b.index));

    return SubCategoryModel(
      id: map['_id'] as String,
      nameAr: map['name_ar'] as String,
      nameEn: map['name_en'] as String,
      isHidden: map['is_hidden'] as bool,
      dailyPrice: double.tryParse(map['daily_price'].toString()) ?? 0,
      portion: double.tryParse(map['portion'].toString()) ?? 0,
      providerPortion: double.tryParse(map['provider_portion'].toString()) ?? 0,
      paymentFactor: double.tryParse(map['payment_factor'].toString()) ?? 0,
      overHeadFactor: double.tryParse(map['over_head_factor'].toString()) ?? 0,
      totalOverHead: double.tryParse(map['total_over_head'].toString()) ?? 0,
      index: map['index'] as int,
      picture: AppConstants.imageBaseUrl + (map['picture'] as String),
      grossMoney: double.tryParse(map['gross_money'].toString()) ?? 0,
      parent: map['parent'] as String,
      props: props,
    );
  }
}
