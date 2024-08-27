import 'package:fourtynine_dashboard/app/core/custom_dio/src/custom_dio.dart';
import 'package:fourtynine_dashboard/app/core/widget/custom_alert.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../data/model/complaint_model.dart';

class ComplaintsController extends GetxController {
  final complaints = RxList<ComplaintModel>();

  Future<void> getData() async {
    try {
      final result = await CustomDio().get('super-admin/complaints');
      complaints.value = result.data['data']
          .map<ComplaintModel>((e) => ComplaintModel.fromMap(e))
          .toList();
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  void showDeleteDialog(ComplaintModel complaint) {
    Get.defaultDialog(
      title: 'Delete Complaint',
      content: 'Are you sure you want to delete this complaint?'.text,
      textCancel: 'Cancel',
      textConfirm: 'Delete',
      onConfirm: () {
        Get.back();
        _deleteComplaint(complaint);
      },
    );
  }

  void _deleteComplaint(ComplaintModel complaint) async {
    try {
      await CustomDio().delete('super-admin/complaints/${complaint.id}');
      complaints.remove(complaint);
      CustomAlert.snackBar(msg: 'Complaint Deleted Successfully');
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
