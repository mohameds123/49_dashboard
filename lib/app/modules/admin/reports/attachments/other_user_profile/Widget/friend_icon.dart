import 'package:flutter/material.dart';

import '../../../../../../core/enums.dart';


class FriendIcon extends StatelessWidget {
  final Function(PeerActionType type) onPress;
  final bool isFriend;
  final bool isFriendRequestSend;
  final bool isOpenFriendRequests;

  const FriendIcon({
    super.key,
    required this.onPress,
    required this.isFriend,
    required this.isFriendRequestSend,
    required this.isOpenFriendRequests,
  });

  @override
  Widget build(BuildContext context) {
    if (!isOpenFriendRequests) {
      return Container(
        height: 35,
        padding: const EdgeInsets.symmetric(vertical: 2),
        decoration: const BoxDecoration(color: Colors.grey),
        child: const Icon(Icons.person, color: Colors.white, size: 20),
      );
    }
    if (isFriendRequestSend && !isFriend) {
      return InkWell(
        onTap: () {
          onPress(PeerActionType.cancelFriendRequest);
        },
        child: Container(
          height: 35,
          padding: const EdgeInsets.symmetric(vertical: 2),
          decoration: const BoxDecoration(
            color: Colors.grey,
          ),
          child: const Icon(
            Icons.person_add_disabled,
            color: Colors.white,
            size: 25,
          ),
        ),
      );
    }
    if (isFriend) {
      return InkWell(
        onTap: () {
          onPress(PeerActionType.unFriend);
        },
        child: Container(
          height: 35,
          padding: const EdgeInsets.symmetric(vertical: 2),
          decoration: const BoxDecoration(color: Color(0xff0b1035)),
          child: const Icon(
            Icons.supervised_user_circle_sharp,
            color: Colors.white,
            size: 25,
          ),
        ),
      );
    }
    return InkWell(
      onTap: () {
        onPress(PeerActionType.addFriend);
      },
      child: Container(
        height: 35,
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: const Icon(Icons.person_add, color: Colors.red, size: 25),
      ),
    );
  }
}
