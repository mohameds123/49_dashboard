import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/enums.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/core/paged_child_builder_delegate.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/ui/paged_list_view.dart';
import '../../../../data/model/report_model.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/reports_controller.dart';

class ReportsView extends GetView<ReportsController> {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getCounts();
          controller.reportsPagingController.refresh();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Column(
              children: [
                DropdownButton<ReportTypes?>(
                  hint: 'Type'.text,
                  isExpanded: true,
                  value: controller.currentType.value,
                  items: List.generate(
                    controller.counts.length,
                    (e) => DropdownMenuItem(
                      value: ReportTypes.values[e],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReportTypes.values[e].name.capitalizeFirst!.text,
                          controller.counts[e].toString().text
                        ],
                      ),
                    ),
                  ).toList(),
                  onChanged: controller.changeCurrentType,
                ),
                if (controller.currentType.value != null)
                  Expanded(
                    child: PagedListView(
                      pagingController: controller.reportsPagingController,
                      builderDelegate: PagedChildBuilderDelegate<ReportModel>(
                        itemBuilder: (context, item, index) =>
                            _buildReportWidget(item),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReportWidget(ReportModel report) {
    return InkWell(
      onTap: () {
        switch (controller.currentType.value!) {
          case ReportTypes.profile:
            Get.toNamed(Routes.OTHER_USER_PROFILE, arguments: report.content);
            break;
          case ReportTypes.post:
            Get.toNamed(Routes.SINGLE_POST, arguments: report.content);
            break;
          case ReportTypes.storyOrReel:
            // TODO: Handle this case.
            break;
          case ReportTypes.dynamicAd:
            Get.toNamed(Routes.DYNAMIC_AD_DETAILS, arguments: report.content);
            break;
          case ReportTypes.restaurant:
            Get.toNamed(Routes.RESTAURANT_DETAILS, arguments: report.content);

            break;
          case ReportTypes.doctor:
            Get.toNamed(Routes.DOCTOR_DETAILS, arguments: report.content);
            break;

          case ReportTypes.tinder:
            Get.toNamed(Routes.OTHER_USER_PROFILE, arguments: report.content);
            break;
          case ReportTypes.rideRequest:
            Get.toNamed(Routes.OTHER_USER_PROFILE, arguments: report.content);
            break;
          case ReportTypes.comeWithMeTrip:
            Get.toNamed(Routes.OTHER_USER_PROFILE, arguments: report.content);
            break;
          case ReportTypes.pickMeTrip:
            Get.toNamed(Routes.OTHER_USER_PROFILE, arguments: report.content);
            break;
          case ReportTypes.message:
            Get.toNamed(Routes.MESSAGE,
                arguments: (jsonDecode(report.content) as List).cast<String>());
            break;
        }
      },
      child: Card(
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
                  'Reporter Name : '.text,
                  Expanded(
                    child: (report.reporter?.fullName ?? '')
                        .text
                        .maxLine(1)
                        .overflowEllipsis
                        .alignEnd,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Divider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  'Reason : '.text,
                  Expanded(
                    child: report.reason.text.alignEnd,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Divider(),
              ),
              Wrap(
                children: [
                  if (report.nudity) 'Nudity ,'.text,
                  if (report.frequent) 'Frequent ,'.text,
                  if (report.fake) 'Fake ,'.text,
                  if (report.abuse) 'Abuse ,'.text,
                  if (report.hated) 'Hated ,'.text,
                  if (report.illegal) 'Illegal ,'.text,
                  if (report.another) 'Another ,'.text,
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Divider(),
              ),
              report.timeAgo.text,
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () => controller.showCancelReportDialog(report),
                    color: Colors.green,
                    textColor: Colors.white,
                    child: 'Cancel'.text,
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () =>
                        controller.showNotificationDialog(report.userId),
                    color: Colors.lightGreen,
                    textColor: Colors.white,
                    child: 'Notify'.text,
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () => controller.showLockDialog(report.userId),
                    color: Colors.red,
                    textColor: Colors.white,
                    child: 'Block'.text,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (controller.currentType.value != ReportTypes.profile &&
                      controller.currentType.value != ReportTypes.tinder &&
                      controller.currentType.value != ReportTypes.rideRequest)
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () =>
                          controller.showDeleteContentDialog(report),
                      color: Colors.red,
                      textColor: Colors.white,
                      child: 'Delete'.text,
                    ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () =>
                        controller.showLockDialog(report.reporterId),
                    color: Colors.deepOrange,
                    textColor: Colors.white,
                    child: 'Block Reporter'.text,
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () =>
                        controller.showNotificationDialog(report.reporterId),
                    color: Colors.amber,
                    textColor: Colors.white,
                    child: 'Notify Reporter'.text,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
