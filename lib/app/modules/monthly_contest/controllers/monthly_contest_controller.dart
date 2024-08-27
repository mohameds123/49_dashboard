import 'package:fourtynine_dashboard/app/data/model/monthly_contest_model.dart';
import 'package:textless/textless.dart';

import '../../../core/custom_dio/src/custom_dio.dart';
import '../../../core/widget/custom_alert.dart';
import '../../../data/model/app_manager_model.dart';
import 'package:get/get.dart';

import '../../super_home/main/controllers/super_home_controller.dart';

class MonthlyContestController extends GetxController {
  final appManagerModel = Rxn<AppManagerModel>();
  final pendingTransitions = RxList<MonthlyContestModel>();
  final users = RxList<MonthlyContestModel>();
  final isWinner = Rxn<bool>();
  final currentYear = Rx<int>(DateTime.now().year);
  final currentMonth = Rx<int>(DateTime.now().month);

  void getData() async {
    try {
      final result = await CustomDio().get('super-admin/app-manager');

      appManagerModel.value = AppManagerModel.fromMap(result.data['data']);
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  void saveData() async {
    try {
      CustomAlert.customLoadingDialog();
      final result = await CustomDio()
          .put('super-admin/app-manager', body: appManagerModel.value!.toMap());

      appManagerModel.value = AppManagerModel.fromMap(result.data['data']);
      Get.back();
      CustomAlert.snackBar(msg: 'Updated');
    } catch (e) {
      Get.back();
      CustomAlert.showError(e.toString());
    }
  }

  Future<void> getPendingTransitions() async {
    try {
      final result = await CustomDio()
          .get('super-admin/get-monthly-contest-pending-transitions');

      pendingTransitions.value = (result.data['data'] as List)
          .map((e) => MonthlyContestModel.fromMap(e))
          .toList();
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  Future<void> getUsers() async {
    try {
      final result = await CustomDio().get(
        'super-admin/get-monthly-contest-users',
        query: {
          'date': '${currentYear.value}-${currentMonth.value}',
          'is_winner': isWinner.value == true
              ? 1
              : isWinner.value == false
                  ? 0
                  : '',
        },
      );
      users.value = (result.data['data'] as List)
          .map((e) => MonthlyContestModel.fromMap(e))
          .toList();
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  Future<void> showAcceptTransitionDialog(
      MonthlyContestModel monthlyContest) async {
    Get.defaultDialog(
      title: 'Accept Transition',
      content: 'Are you sure you want to accept this transition?'.text,
      textConfirm: 'Accept',
      textCancel: 'Cancel',
      onConfirm: () => _acceptTransition(monthlyContest),
    );
  }

  Future<void> _acceptTransition(MonthlyContestModel monthlyContest) async {
    try {
      Get.back();
      CustomAlert.customLoadingDialog();
      await CustomDio().put(
          'super-admin/accept-monthly-contest-transition/${monthlyContest.id}');
      CustomAlert.snackBar(msg: 'Accepted');
      pendingTransitions.removeWhere((e) => e.id == monthlyContest.id);
      Get.find<SuperHomeController>().sendNotificationToUser(
        monthlyContest.userId,
        'المسابقة الشهرية',
        'تم قبول اشتراكك في المسابقة الشهرية',
        'Monthly Contest',
        'Your participation in the monthly contest has been accepted',
      );
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  Future<void> showDeclineTransitionDialog(
      MonthlyContestModel monthlyContest) async {
    Get.defaultDialog(
      title: 'Decline Transition',
      content: 'Are you sure you want to decline this transition?'.text,
      textConfirm: 'Decline',
      textCancel: 'Cancel',
      onConfirm: () => _declineTransition(monthlyContest),
    );
  }

  Future<void> _declineTransition(MonthlyContestModel monthlyContest) async {
    try {
      Get.back();
      CustomAlert.customLoadingDialog();
      await CustomDio().put(
          'super-admin/decline-monthly-contest-transition/${monthlyContest.id}');
      CustomAlert.snackBar(msg: 'Declined');
      pendingTransitions.removeWhere((e) => e.id == monthlyContest.id);
      Get.find<SuperHomeController>().sendNotificationToUser(
        monthlyContest.userId,
        'المسابقة الشهرية',
        'تم رفض اشتراكك في المسابقة الشهرية',
        'Monthly Contest',
        'Your participation in the monthly contest has been declined',
      );
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
