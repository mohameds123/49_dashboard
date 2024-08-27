import '../../core/constants.dart';

class FoodItemModel {
  final String id;
   String name;
  final String restaurantName;
   String desc;
  final double price;
  final String? picture;

  FoodItemModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.picture,
    required this.restaurantName,
  });

  factory FoodItemModel.fromMap(Map<String, dynamic> map) {
    return FoodItemModel(
      id: map['_id'] as String,
      name: map['name'] as String,
      price: double.parse(map['price'].toString()),
      desc: map['desc'] as String,
      restaurantName: map['restaurant_name'] as String,
      picture: map['picture'] == null
          ? null
          : AppConstants.imageBaseUrl + (map['picture'] as String),
    );
  }
}
