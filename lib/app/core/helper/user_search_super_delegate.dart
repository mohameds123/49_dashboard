import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../data/model/profile_model.dart';
import '../custom_dio/src/custom_dio.dart';
import '../widget/custom_alert.dart';

class UserSearchSuperDelegate extends SearchDelegate {
  final String endPoint;
  final Function(ProfileModel) onNotificationClick;
  final Function(ProfileModel)? onCardClick;
  final Function(ProfileModel)? onBlockClick;
  final Function(ProfileModel)? onUnBlockClick;
  final Function(ProfileModel)? onDeleteClick;
  final Function(ProfileModel)? onSubscriptionClick;
  List<ProfileModel> results = [];

  UserSearchSuperDelegate(
    this.endPoint,
    this.onNotificationClick, {
    this.onCardClick,
    this.onBlockClick,
    this.onUnBlockClick,
    this.onDeleteClick,
    this.onSubscriptionClick,
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
                  return _buildUserCard(results[index]);
                },
                itemCount: results.length,
              )
            : const Text('Loading...'));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _buildUserCard(results[index]);
      },
      itemCount: results.length,
    );
  }

  Widget _buildUserCard(ProfileModel profile) {
    return InkWell(
      onTap: () => onCardClick!(profile),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              profile.fullName.text.bold.size(14).color(Colors.red),
              SizedBox(height: 15),
              (profile.phone ?? '').text.bold.size(14).color(Colors.red),
              SizedBox(height: 15),
              profile.email.text.bold.size(14).color(Colors.red),
              SizedBox(height: 5),
              profile.provider.text.bold.size(14).color(Colors.red),
              SizedBox(height: 5),
              Row(
                children: [
                  IconButton(
                    onPressed: () => onNotificationClick(profile),
                    icon: Icon(
                      Icons.notifications_none,
                      color: Get.theme.primaryColor,
                    ),
                  ),
                  if (onBlockClick != null)
                    IconButton(
                      onPressed: () => onBlockClick!(profile),
                      icon: Icon(
                        Icons.block,
                        color: Get.theme.primaryColor,
                      ),
                    ),
                  if (onUnBlockClick != null)
                    IconButton(
                      onPressed: () => onUnBlockClick!(profile),
                      icon: Icon(
                        profile.isLocked ? Icons.clear : Icons.check,
                        color: Get.theme.primaryColor,
                      ),
                    ),
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: profile.id),
                      );
                      CustomAlert.snackBar(
                        msg: 'The User ID has been successfully copied',
                      );
                    },
                    icon: Icon(
                      Icons.copy,
                      color: Get.theme.primaryColor,
                    ),
                  ),
                  if (onDeleteClick != null)
                    IconButton(
                      onPressed: () => onDeleteClick!(profile),
                      icon: Icon(
                        Icons.delete_outline,
                        color: Get.theme.primaryColor,
                      ),
                    ),
                  if (onSubscriptionClick != null)
                    IconButton(
                      onPressed: () => onSubscriptionClick!(profile),
                      icon: Icon(
                        Icons.card_giftcard,
                        color: Get.theme.primaryColor,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> search() async {
    if (query.length > 2) {
      try {
        final result = await CustomDio().post(
          endPoint,
          body: {'data': query},
        );
        results = (result.data['data'] as List)
            .map((e) => ProfileModel.fromMap(e))
            .toList();
      } catch (e) {
        CustomAlert.showError(e.toString());
      }
    }
  }
}
