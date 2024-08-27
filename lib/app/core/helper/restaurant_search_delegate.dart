import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';
import '../../data/model/restaurant_model.dart';
import '../custom_dio/src/custom_dio.dart';
import '../widget/custom_alert.dart';

class RestaurantSearchDelegate extends SearchDelegate {
  final Function(RestaurantModel) onCardClick;
  final Function(RestaurantModel) onBlockClick;
  final Function(RestaurantModel) onDeleteClick;

  List<RestaurantModel> results = [];

  RestaurantSearchDelegate({
    required this.onDeleteClick,
    required this.onCardClick,
    required this.onBlockClick,
  });

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: search(),
        builder: (_, snapshot) => results.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return _buildRestaurantCard(results[index]);
                },
                itemCount: results.length,
              )
            : const Text('Loading...'));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _buildRestaurantCard(results[index]);
      },
      itemCount: results.length,
    );
  }

  Future<void> search() async {
    if (query.length > 2) {
      try {
        final result = await CustomDio().post(
          'super-admin/search-restaurants',
          body: {'data': query},
        );
        results = (result.data['data'] as List)
            .map((e) => RestaurantModel.fromMap(e))
            .toList();
      } catch (e) {
        CustomAlert.showError(e.toString());
      }
    }
  }

  Widget _buildRestaurantCard(RestaurantModel restaurant) {
    return InkWell(
      onTap: () => onCardClick(restaurant),
      child: Card(
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (restaurant.user?.fullName ?? '').text.bold.size(18),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        NetworkImage(restaurant.user?.profilePicture ?? ''),
                  )
                ],
              ),
              SizedBox(height: 5),
              Divider(),
              (Get.locale?.languageCode == 'ar'
                      ? restaurant.category!.nameAr
                      : restaurant.category!.nameEn)
                  .text,
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () => onDeleteClick(restaurant),
                      child: 'Delete Restaurant'.text,
                      textColor: Colors.white,
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: MaterialButton(
                      onPressed: () => onBlockClick(restaurant),
                      child: 'Block'.text,
                      textColor: Colors.white,
                      color: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
