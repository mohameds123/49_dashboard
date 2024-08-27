import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../../main.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../data/model/pick_me_trip_model.dart';

class PickMeWidget extends StatelessWidget {
  final PickMeTripModel pickMeTrip;
  final VoidCallback onDeleteClick;
  final VoidCallback? onApproveClick;

  const PickMeWidget({
    super.key,
    required this.pickMeTrip,
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
          crossAxisAlignment: CrossAxisAlignment.end,
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
              child:
                  pickMeTrip.price.toString().text.color(Colors.white).size(18),
            ),
            const SizedBox(height: 5),
            const Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                'from'.tr.text.bold.color(mainColor).size(18),
                const SizedBox(width: 10),
                Expanded(
                  child: '(${pickMeTrip.from})'
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
                  child: '(${pickMeTrip.to})'
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
                pickMeTrip.duration
                    .replaceFirst('hours', 'hours'.tr)
                    .replaceFirst('hour', 'hour'.tr)
                    .replaceFirst('mins', 'mins'.tr)
                    .text
                    .bold
                    .color(mainColor)
                    .size(16),
                pickMeTrip.distance
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
                (pickMeTrip.isRepeat ? 'Repeat'.tr : 'Once'.tr)
                    .text
                    .bold
                    .color(mainColor)
                    .size(16),
                pickMeTrip.tripTime.text.bold.color(mainColor).size(16),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                '${pickMeTrip.passengers} ${'Passengers'.tr}'
                    .text
                    .bold
                    .color(mainColor)
                    .size(16),
                pickMeTrip.timeAgo.text.size(12),
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
                if (pickMeTrip.user != null)
                  GestureDetector(
                    onTap: (){
                      Clipboard.setData(
                        ClipboardData(text: pickMeTrip.user!.fullName),
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
                              pickMeTrip.user!.profilePicture),
                        ),
                        pickMeTrip.user!.id.text.overflowEllipsis,
                        pickMeTrip.user!.fullName.text.overflowEllipsis,
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
