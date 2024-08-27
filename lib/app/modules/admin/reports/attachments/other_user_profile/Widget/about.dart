import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../../../../main.dart';
import '../../../../../../core/enums.dart';
import '../../../../../../data/model/report/peer_profile_model.dart';
import '../../../../../../routes/app_pages.dart';

class About extends StatelessWidget {
  final PeerProfileModel peerProfile;

  const About({
    super.key,
    required this.peerProfile,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'About'.tr,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.help_outline,
                  color: Colors.red,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            infoWidget('Name'.tr, peerProfile.user.fullName),
            if (peerProfile.phone != null)
              infoWidget(
                'Phone'.tr,
                peerProfile.phone!,
              ),
            if (peerProfile.isMale != null)
              infoWidget(
                'Gender'.tr,
                peerProfile.isMale == true ? 'Male'.tr : 'Female'.tr,
              ),
            if (peerProfile.socialStatus != null)
              infoWidget(
                'Social Status'.tr,
                getSocialStatusName(
                  peerProfile.socialStatus,
                ),
              ),
            if (peerProfile.birthDate != null &&
                peerProfile.birthDate!.isNotEmpty)
              infoWidget(
                'Birth date'.tr,
                peerProfile.birthDate!,
              ),
            if (peerProfile.job != null && peerProfile.job!.isNotEmpty)
              infoWidget(
                'Job'.tr,
                peerProfile.job!,
              ),
            if (peerProfile.city != null && peerProfile.city!.isNotEmpty)
              infoWidget(
                'City'.tr,
                peerProfile.city!,
              ),
            if (peerProfile.country != null && peerProfile.country!.isNotEmpty)
              infoWidget(
                'Country'.tr,
                peerProfile.country!,
              ),
            if (peerProfile.referralName != null)
              InkWell(
                onTap: () async {
                  Get.back();
                  Get.toNamed(
                    Routes.OTHER_USER_PROFILE,
                    arguments: peerProfile.referralId,
                    preventDuplicates: false,
                  );
                },
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        'Referral'.tr.text.color(Colors.red).size(18),
                        peerProfile.referralName!.text
                            .size(18)
                            .color(mainColor),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget infoWidget(String title, String info) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(info.trim()),
          ],
        ),
        const Divider(),
      ],
    );
  }

  static String getSocialStatusName(SocialStatus? socialStatus) {
    if (socialStatus == SocialStatus.single) {
      return 'Single'.tr;
    } else if (socialStatus == SocialStatus.married) {
      return 'Married'.tr;
    } else if (socialStatus == SocialStatus.divorced) {
      return 'Divorced'.tr;
    } else if (socialStatus == SocialStatus.inARelationship) {
      return 'in a Relationship'.tr;
    } else if (socialStatus == SocialStatus.idLikeToNoTell) {
      return 'i`d Like to No Tell'.tr;
    } else {
      return '';
    }
  }
}
