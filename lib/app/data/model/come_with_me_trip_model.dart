import 'package:equatable/equatable.dart';
import '../../core/helper/date.dart';
import '../../core/helper/timeago.dart';
import 'base_user.dart';

class ComeWithMeTripModel extends Equatable with TimeAgoMixin {
  final String id;
  final String userId;
  final String carBrand;
  final String carType;
  final double userLat;
  final double userLng;
  final double destinationLat;
  final double destinationLng;
  final String from;
  final String to;
  final String distance;
  final String duration;
  final int passengers;
  final double price;
  final bool isRepeat;
  final String tripTime;
  final DateTime createdAt;
  final bool isSubscription;

  final BaseUser? user;
  const ComeWithMeTripModel({
    required this.id,
    required this.userId,
    required this.carBrand,
    required this.carType,
    required this.userLat,
    required this.userLng,
    required this.destinationLat,
    required this.destinationLng,
    required this.from,
    required this.to,
    required this.distance,
    required this.duration,
    required this.passengers,
    required this.price,
    required this.isRepeat,
    required this.tripTime,
    required this.createdAt,
    required this.isSubscription,
    required this.user,
  });

  factory ComeWithMeTripModel.fromMap(Map<String, dynamic> map) {
    return ComeWithMeTripModel(
      userId: map['user_id'] as String,
      id: map['_id'] as String,
      carBrand: map['car_brand'] as String,
      carType: map['car_type'] as String,
      userLat: double.parse(map['user_lat'].toString()),
      userLng: double.parse(map['user_lng'].toString()),
      destinationLat: double.parse(map['destination_lat'].toString()),
      destinationLng: double.parse(map['destination_lng'].toString()),
      from: map['from'] as String,
      to: map['to'] as String,
      distance: map['distance'] as String,
      duration: map['duration'] as String,
      passengers: map['passengers'] as int,
      price: double.parse(map['price'].toString()),
      isRepeat: map['is_repeat'] as bool,
      tripTime: map['time'] as String,
      isSubscription: map['is_subscription'] as bool? ?? false,
      createdAt: (map['createdAt'] as String).toDate(),
      user: map['user'] != null ? BaseUser.fromMap(map['user']) : null,
    );
  }

  @override
  DateTime get time => createdAt;

  @override
  List<Object?> get props => [id];
}
