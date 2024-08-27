import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../data/model/base_user.dart';
import '../custom_dio/src/custom_dio.dart';
import '../widget/custom_alert.dart';

class UserSearchDelegate extends SearchDelegate {
  final String endPoint;
  final Function(BaseUser) onNotificationClick;
  final Function(BaseUser)? onCardClick;
  final Function(BaseUser)? onBlockClick;
  final Function(BaseUser)? onUnBlockClick;
  List<BaseUser> results = [];

  UserSearchDelegate(this.endPoint, this.onNotificationClick,
      {this.onCardClick, this.onBlockClick, this.onUnBlockClick});

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

  Widget _buildUserCard(BaseUser user) {
    return Card(
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
            user.fullName.text.bold.size(14).color(Colors.red),
            SizedBox(height: 15),
            user.phone.text.bold.size(14).color(Colors.red),
            SizedBox(height: 5),
            Row(
              children: [
                IconButton(
                  onPressed: () => onNotificationClick(user),
                  icon: Icon(
                    Icons.notifications_none,
                    color: Get.theme.primaryColor,
                  ),
                ),
                if (onBlockClick != null)
                  IconButton(
                    onPressed: () => onBlockClick!(user),
                    icon: Icon(
                      Icons.block,
                      color: Get.theme.primaryColor,
                    ),
                  ),
                if (onUnBlockClick != null)
                  IconButton(
                    onPressed: () => onUnBlockClick!(user),
                    icon: Icon(
                      user.isLocked ? Icons.clear : Icons.check,
                      color: Get.theme.primaryColor,
                    ),
                  ),
                IconButton(
                  onPressed: () {
                    Clipboard.setData(
                      ClipboardData(text: user.id),
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
              ],
            ),
          ],
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
            .map((e) => BaseUser.fromMap(e))
            .toList();
      } catch (e) {
        CustomAlert.showError(e.toString());
      }
    }
  }
}
