import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../../main.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../data/model/come_with_me_trip_model.dart';

class ComeWithMeWidget extends StatelessWidget {
  final ComeWithMeTripModel comeWithMeTrip;
  final VoidCallback onDeleteClick;
  final VoidCallback? onApproveClick;

  const ComeWithMeWidget({
    super.key,
    required this.comeWithMeTrip,
    required this.onDeleteClick,
    this.onApproveClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xfff6f6f6),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.red),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: comeWithMeTrip.price
                      .toString()
                      .text
                      .color(Colors.white)
                      .size(16),
                ),
              ],
            ),
            '${comeWithMeTrip.carBrand} | ${comeWithMeTrip.carType}'
                .text
                .bold
                .color(Colors.red)
                .maxLine(2)
                .overflowEllipsis
                .size(18),
            const SizedBox(height: 5),
            const Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                'from'.tr.text.bold.color(mainColor).size(18),
                const SizedBox(width: 10),
                Expanded(
                  child: '(${comeWithMeTrip.from})'
                      .text
                      .size(16)
                      .maxLine(2)
                      .overflowEllipsis,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'to'.tr.text.bold.color(mainColor).size(18),
                const SizedBox(width: 25),
                Expanded(
                  child: '(${comeWithMeTrip.to})'
                      .text
                      .size(16)
                      .maxLine(2)
                      .overflowEllipsis,
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                comeWithMeTrip.duration
                    .replaceFirst('hours', 'hours'.tr)
                    .replaceFirst('hour', 'hour'.tr)
                    .replaceFirst('mins', 'mins'.tr)
                    .text
                    .bold
                    .color(mainColor)
                    .size(16),
                comeWithMeTrip.distance
                    .replaceFirst('mi', 'mi'.tr)
                    .replaceFirst('km', 'KM'.tr)
                    .text
                    .bold
                    .color(mainColor)
                    .size(16)
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (comeWithMeTrip.isRepeat ? 'Repeat'.tr : 'Once'.tr)
                    .text
                    .bold
                    .color(mainColor)
                    .size(16),
                comeWithMeTrip.tripTime.text.bold.color(mainColor).size(16),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                '${comeWithMeTrip.passengers} ${'Passengers'.tr}'
                    .text
                    .bold
                    .color(mainColor)
                    .size(16),
                comeWithMeTrip.timeAgo.text.size(12),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  onPressed: onDeleteClick,
                  color: Colors.red,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: 'Delete'.tr.text,
                ),
                if (onApproveClick != null)
                  MaterialButton(
                    onPressed: onApproveClick,
                    color: Colors.green,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: 'Approve'.tr.text,
                  ),
                if (comeWithMeTrip.user != null)
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(
                        ClipboardData(text: comeWithMeTrip.user!.fullName),
                      );
                      CustomAlert.snackBar(
                        msg: 'The User Name has been successfully copied',
                      );
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: CachedNetworkImageProvider(
                              comeWithMeTrip.user!.profilePicture),
                        ),
                        comeWithMeTrip.user!.id.text.overflowEllipsis,
                        comeWithMeTrip.user!.fullName.text.overflowEllipsis,
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
