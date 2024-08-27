import 'package:flutter/material.dart';
import 'package:fourtynine_dashboard/app/modules/monthly_contest/views/monthly_contest_users_view.dart';
import '../../../core/widget/custom_text_field_with_background.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../controllers/monthly_contest_controller.dart';
import 'monthly_contest_pending_transitions_view.dart';

class MonthlyContestView extends GetView<MonthlyContestController> {
  const MonthlyContestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Contest'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Obx(
          () {
            final appManager = controller.appManagerModel.value;
            return appManager == null
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        ValueBuilder<bool?>(
                          initialValue: appManager.isMonthlyContestAvailable,
                          onUpdate: (v) =>
                              appManager.isMonthlyContestAvailable = v!,
                          builder: (value, update) => SwitchListTile(
                            title: 'Is Monthly Contest Available'.text,
                            value: value!,
                            onChanged: update,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomTextFieldWithBackground(
                            label: 'Monthly Contest Fees',
                            initValue: appManager.monthlyContestFees.toString(),
                            onChange: (v) => appManager.monthlyContestFees =
                                double.tryParse(v) ??
                                    appManager.monthlyContestFees,
                            textInputType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomTextFieldWithBackground(
                            label: 'Monthly Contest Reward',
                            initValue:
                                appManager.monthlyContestReward.toString(),
                            onChange: (v) => appManager.monthlyContestReward =
                                double.tryParse(v) ??
                                    appManager.monthlyContestReward,
                            textInputType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomTextFieldWithBackground(
                            label: 'Insta Pay Number',
                            initValue: appManager.instantPayNumber.toString(),
                            onChange: (v) => appManager.instantPayNumber = v,
                            textInputType: TextInputType.number,
                          ),
                        ),
                        MaterialButton(
                          child: 'Save'.text,
                          color: Get.theme.primaryColor,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minWidth: double.infinity,
                          onPressed: controller.saveData,
                        ),
                        Divider(height: 70),
                        MaterialButton(
                          child: 'Pending Transactions'.text,
                          color: Get.theme.primaryColor,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minWidth: double.infinity,
                          onPressed: () {
                            controller.getPendingTransitions();
                            Get.to(MonthlyContestPendingTransitionsView());
                          },
                        ),
                        MaterialButton(
                          child: 'Users'.text,
                          color: Get.theme.primaryColor,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minWidth: double.infinity,
                          onPressed: () {
                            controller.getUsers();
                            Get.to(MonthlyContestUsersView());
                          },
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
