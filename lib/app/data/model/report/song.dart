import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../core/constants.dart';
import '../base_user.dart';
// ignore: must_be_immutable
class Song extends Equatable {
  final String id;
  final String name;
  final String playUrl;
  String? playPath;
  final int duration;
  @protected
  final String? thumbUrl;
  final BaseUser? user;
  final int times;

  Song({
    required this.id,
    required this.name,
    required this.playUrl,
    this.playPath,
    required this.duration,
    this.thumbUrl,
    required this.times,
    this.user,
  });

  String get getThumb =>
      thumbUrl ??
      (user != null
          ? user!.profilePicture
          : 'https://play-lh.googleusercontent.com/EpQO_fo1zfD31XTKXae4S5ImIQd0s5FyFCEcQ1TfdXeLKMidQqCd2dGwtjE7F7V5z_E=s64-rw');

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      id: map['_id'] as String,
      name: map['name'] as String,
      playUrl: AppConstants.imageBaseUrl + (map['play_url'] as String),
      duration: double.parse(map['duration'].toString()).round(),
      times: map['times'] as int? ?? 0,
      thumbUrl: map['thumb_url'] != null
          ? AppConstants.imageBaseUrl + map['thumb_url'].toString()
          : null,
      user: map['user'] != null
          ? BaseUser.fromMap(map['user'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  List<Object?> get props => [id];
}
