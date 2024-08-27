import '../../core/constants.dart';
import '../../core/enums.dart';

class NewChatAttachmentModel {
  ChatAttachmentTypes type;
  String url;

  double? locationLat;
  double? locationLng;

  NewChatAttachmentModel({
    required this.type,
    required this.url,
    this.locationLat,
    this.locationLng,
  });

  factory NewChatAttachmentModel.fromMap(Map<String, dynamic> map) {
    final type = ChatAttachmentTypes.values[(map['type'] as int) - 1];
    return NewChatAttachmentModel(
      type: type,
      url: type == ChatAttachmentTypes.location
          ? ''
          : AppConstants.imageBaseUrl + (map['url'] as String),
      locationLng: type == ChatAttachmentTypes.location
          ? map['location_lng'] as double?
          : null,
      locationLat: type == ChatAttachmentTypes.location
          ? map['location_lat'] as double?
          : null,
    );
  }

}
