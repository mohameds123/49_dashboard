import 'package:flutter/material.dart';

import '../../../../../../../main.dart';

class FollowIcon extends StatelessWidget {
  final bool isFollowing;
  final Function(bool type) onPress;

  const FollowIcon({super.key, required this.isFollowing, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress(!isFollowing);
      },
      child: Container(
        height: 35,
        color: isFollowing ? mainColor : null,
        child: const Icon(
          Icons.group_add,
          color: Colors.red,
          size: 25,
        ),
      ),
    );
  }
}
