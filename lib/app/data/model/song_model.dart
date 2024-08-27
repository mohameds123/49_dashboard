import '../../core/constants.dart';

class SongModel {
  final String id;
  final String name;
  final String desc;
  final String playUrl;
  String? playPath;
  final int duration;
  final String thumbUrl;

  SongModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.playUrl,
    this.playPath,
    required this.duration,
    required this.thumbUrl,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'desc': this.desc,
      'play_url': this.playUrl.replaceFirst(AppConstants.imageBaseUrl, ''),
      'duration': this.duration,
      'thumb_url': this.thumbUrl.replaceFirst(AppConstants.imageBaseUrl, ''),
    };
  }

  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
      id: map['_id'] as String,
      name: map['name'] as String,
      desc: map['desc'] as String,
      playUrl: AppConstants.imageBaseUrl + (map['play_url'] as String),
      duration: map['duration'] as int,
      thumbUrl: map['thumb_url'] != null
          ? AppConstants.imageBaseUrl + (map['thumb_url'] as String)
          : 'https://play-lh.googleusercontent.com/EpQO_fo1zfD31XTKXae4S5ImIQd0s5FyFCEcQ1TfdXeLKMidQqCd2dGwtjE7F7V5z_E=s64-rw',
    );
  }
}
