import '../../../core/constants.dart';
import '../../../core/enums.dart';
import 'dynamic_multi_selected_model.dart';

class DynamicPropModel {
  final String id;
  String nameAr;
  String nameEn;
  DynamicAdInputType? type;
  int index;


  String value;
  List values;
  int? attachmentIndex;
  List<DynamicMultiSelectionsModel> selections;

  DynamicPropModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    this.type,
    required this.selections,
    required this.value,
    required this.values,
    required this.index,
  });

  factory DynamicPropModel.fromMap(Map<String, dynamic> map) {
    final inputType =
        DynamicAdInputType.values[int.parse(map['type'].toString())];
    return DynamicPropModel(
      id: map['_id'] as String? ?? map['id'],
      nameAr: map['name_ar'] ?? '',
      nameEn: map['name_en'] ?? map['name'],
      type: inputType,
      index: map['index'],
      value: getValue(map['value'] as String?, inputType),
      values: map['values'] as List? ?? [],
      selections: (map['selections'] as List? ?? [])
          .map(
            (e) =>
                DynamicMultiSelectionsModel.fromMap(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        '_id': id,
        'name_ar': nameAr,
        'name_en': nameEn,
        'type': type!.index,
        'index': index,
        'selections': selections
            .map(
              (e) => {
                'ar': e.nameAr,
                'en': e.nameEn,
              },
            )
            .toList()
      };

  static String getValue(String? value, DynamicAdInputType inputType) {
    return value == null
        ? ''
        : inputType == DynamicAdInputType.videoPicker ||
                inputType == DynamicAdInputType.pdfPicker
            ? AppConstants.imageBaseUrl + value
            : value;
  }

  DynamicPropModel copyWith({
    String? id,
    String? nameAr,
    String? nameEn,
    DynamicAdInputType? type,
    int? index,
    String? value,
    List? values,
    List<DynamicMultiSelectionsModel>? selections,
  }) {
    return DynamicPropModel(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      type: type ?? this.type,
      index: index ?? this.index,
      value: value ?? this.value,
      values: values ?? this.values,
      selections: selections ?? this.selections,
    );
  }
}
