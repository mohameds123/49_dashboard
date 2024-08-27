import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/enums.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/core/paging_controller.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/report_model.dart';
import '../../home/controllers/home_controller.dart';

class ReportsController extends GetxController {
  final currentType = Rxn<ReportTypes>();

  final counts = ReportTypes.values.map((_) => 0).toList();

  late final reportsPagingController =
  PagingController<int, ReportModel>(firstPageKey: 1)
    ..addPageRequestListener(_fetchReportsPage);

  void changeCurrentType(ReportTypes? type) {
    if (type != null && currentType != type) {
      currentType.value = type;
      reportsPagingController.refresh();
    }
  }

  @override
  void onInit() {
    getCounts();
    super.onInit();
  }

  void getCounts() async {
    try {
      final result = await CustomDio().get('admin/reports-counts');

      for (final item in result.data['data'] as List) {
        counts[item['_id'] - 1] = item['count'];
      }
      currentType.refresh();
    } catch (_) {}
  }

  Future<void> _fetchReportsPage(int pageKey) async {
    try {
      final result = await CustomDio(enableLog: true)
          .get('admin/reports/${currentType.value!.index + 1}?page=$pageKey');

      final newItemsResult =
      ((result.data as Map<String, dynamic>)['data'] as List)
          .map((e) => ReportModel.fromMap(e as Map<String, dynamic>))
          .toList();

      final newItems = newItemsResult
          .where((e) => !reportsPagingController.itemList.contains(e))
          .toList();

      final isLastPage = newItemsResult.isEmpty;
      if (isLastPage) {
        reportsPagingController.appendLastPage(newItems);
      } else {
        reportsPagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (error) {
      reportsPagingController.error = error;
    }
  }

  void showCancelReportDialog(ReportModel report) {
    Get.defaultDialog(
      title: 'Confirm!',
      middleText: 'Are you sure you want to cancel this Report?',
      textCancel: 'No',
      textConfirm: 'Yes',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        _cancelReport(report);
      },
    );
  }

  Future<void> _cancelReport(ReportModel report) async {
    try {
      await CustomDio().get('admin/cancel-report/${report.id}');
      CustomAlert.snackBar(msg: 'Success Report Canceled.');
      reportsPagingController.removeItem(report);
      counts[currentType.value!.index] -= 1;
      if (Get.isRegistered<HomeController>()) {
        Get
            .find<HomeController>()
            .reportsCounts
            .value--;
      }
      currentType.refresh();
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  void showNotificationDialog(String userId) {
    String titleAr = '';
    String titleEn = '';
    String bodyAr = '';
    String bodyEn = '';

    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFieldWithBackground(
              label: 'Title Ar',
              onChange: (v) => titleAr = v,
              textInputType: TextInputType.multiline,
            ),
            SizedBox(height: 10),
            CustomTextFieldWithBackground(
              label: 'Title En',
              onChange: (v) => titleEn = v,
              textInputType: TextInputType.multiline,
            ),
            SizedBox(height: 10),
            CustomTextFieldWithBackground(
              label: 'Body Ar',
              onChange: (v) => bodyAr = v,
              textInputType: TextInputType.multiline,
            ),
            SizedBox(height: 10),
            CustomTextFieldWithBackground(
              label: 'Body En',
              onChange: (v) => bodyEn = v,
              textInputType: TextInputType.multiline,
            ),
            SizedBox(height: 10),
            MaterialButton(
              child: 'Send'.text,
              color: Get.theme.primaryColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minWidth: double.infinity,
              onPressed: () =>
                  sendNotificationToUser(
                      userId, titleAr, titleEn, bodyAr, bodyEn),
            )
          ],
        ),
      ),
    );
  }

  void sendNotificationToUser(String userId, String titleAr, String titleEn,
      String bodyAr, String bodyEn) async {
    try {
      Get.back();
      await CustomDio(enableLog: true).post(
        'admin/send-notification',
        body: {
          'user_id': userId,
          'title_ar': titleAr,
          'title_en': titleEn,
          'body_ar': bodyAr,
          'body_en': bodyEn,
        },
      );
      CustomAlert.snackBar(msg: 'Success Send Notification.');
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  void showLockDialog(String userId) {
    int days = 0;

    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            'Block This User?'.text,
            SizedBox(height: 10),
            CustomTextFieldWithBackground(
              label: 'Days',
              onChange: (v) => days = int.tryParse(v) ?? 0,
              textInputType: TextInputType.number,
            ),
            SizedBox(height: 10),
            MaterialButton(
              child: 'Block'.text,
              color: Get.theme.primaryColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minWidth: double.infinity,
              onPressed: () => lockUser(userId, days),
            )
          ],
        ),
      ),
    );
  }

  void lockUser(String userId, int days) async {
    try {
      Get.back();

      await CustomDio().post(
        'super-admin/lock-user',
        body: {
          'user_id': userId,
          'days': days,
        },
      );
      CustomAlert.snackBar(msg: 'Success User Bocked.');
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  void showDeleteContentDialog(ReportModel report) {
    Get.defaultDialog(
      title: 'Confirm!',
      middleText: 'Are you sure you want to Delete this Content?',
      textCancel: 'No',
      textConfirm: 'Yes',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        _deleteContent(report);
      },
    );
  }

  Future<void> _deleteContent(ReportModel report) async {
    try {
      if (currentType.value == ReportTypes.post) {
        await CustomDio(enableLog: true).delete(
            'admin/delete-post/${report.content}');
      }
      else if (currentType.value == ReportTypes.dynamicAd) {
        await CustomDio().delete('admin/delete-dynamic-ad/${report.content}');
      }
      else if (currentType.value == ReportTypes.restaurant) {
        await CustomDio().delete('admin/delete-restaurant/${report.content}');
      }
      else if (currentType.value == ReportTypes.doctor) {
        await CustomDio().delete('admin/delete-doctor/${report.content}');
      }
      else if (currentType.value == ReportTypes.comeWithMeTrip) {
        await CustomDio().delete(
            'admin/delete-come-with-me-trip/${report.content}');
      }
      else if (currentType.value == ReportTypes.pickMeTrip) {
        await CustomDio().delete('admin/delete-pick-me-trip/${report.content}');
      }
      else if (currentType.value == ReportTypes.message) {
        await CustomDio().post('admin/delete-chat-messages', body: {
        'ids' : (jsonDecode(report.content) as List).cast<String>(),
        });
      }

      await _cancelReport(report);
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }
}
