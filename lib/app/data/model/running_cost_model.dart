import '../../core/helper/date.dart';

class RunningCostModel {
  final String id;
  final String note;
  final int type;
  final double cost;
  final DateTime createdAt;

  const RunningCostModel({
    required this.id,
    required this.note,
    required this.type,
    required this.cost,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'note': this.note,
      'type': this.type,
      'cost': this.cost,
    };
  }

  factory RunningCostModel.fromMap(Map<String, dynamic> map) {
    return RunningCostModel(
      id: map['_id'] as String,
      note: map['note'] as String,
      type: map['type'] as int,
      cost: double.tryParse(map['cost'].toString()) ?? 0,
      createdAt: (map['createdAt'] as String).toDate(),
    );
  }
}
