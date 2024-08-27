import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fourtynine_dashboard/app/modules/users_profile/data/models/all_users_profile_model.dart';
import 'package:fourtynine_dashboard/main.dart';

class AllUsersItemWidget extends StatelessWidget {
  AllUsersItemWidget({super.key, required this.userDataProfileModel});

  UserDataProfileModel? userDataProfileModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: mainColor, width: 1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          CircleAvatar(
            child: CachedNetworkImage(
                imageUrl: userDataProfileModel!
                        .userProfile!.profilePictureKey!.mediaKey ??
                    ""),
          ),
          SizedBox(
            width: 15,

          ),
          Text(
              "${userDataProfileModel!.firstName!} ${userDataProfileModel!.lastName}"),
        ],
      ),
    );
  }
}
