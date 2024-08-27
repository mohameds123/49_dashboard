import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../controllers/monthly_contest_controller.dart';

class MonthlyContestUsersView extends GetView<MonthlyContestController> {
  const MonthlyContestUsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Contest Users'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(
          () {
            final now = DateTime.now();
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton<int>(
                        isExpanded: true,
                        hint: 'Select Year'.text,
                        value: controller.currentYear.value,
                        items: List.generate(
                          30,
                          (index) => DropdownMenuItem(
                            value: now.year + index,
                            child: Text(
                              (now.year + index).toString(),
                            ),
                          ),
                        ),
                        onChanged: (v) {
                          controller.currentYear.value = v!;
                          controller.getUsers();
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: DropdownButton<int>(
                        isExpanded: true,
                        hint: 'Select Month'.text,
                        value: controller.currentMonth.value,
                        items: List.generate(
                          12,
                          (index) => DropdownMenuItem(
                            value: index + 1,
                            child: Text(
                              (index + 1).toString(),
                            ),
                          ),
                        ),
                        onChanged: (v) {
                          controller.currentMonth.value = v!;
                          controller.getUsers();
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: DropdownButton<bool?>(
                        isExpanded: true,
                        hint: 'Select Year'.text,
                        value: controller.isWinner.value,
                        items: [
                          DropdownMenuItem(
                            value: null,
                            child: 'All'.text.maxLine(1),
                          ),
                          DropdownMenuItem(
                            value: true,
                            child: 'Winners'.text.maxLine(1),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: 'Not Winners'.text.maxLine(1),
                          ),
                        ],
                        onChanged: (v) {
                          controller.isWinner.value = v;
                          controller.getUsers();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.users.length,
                    itemBuilder: (context, index) {
                      final user = controller.users[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: (user.user?.fullName ?? '').text,
                            subtitle: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                '${user.times} Ads'.text,
                                user.phone.text,
                                user.isWinner
                                    ? 'Winner'.text.color(Colors.green)
                                    : 'Not Winner'.text.color(Colors.red)
                              ],
                            ),
                            trailing: CircleAvatar(
                              backgroundImage: user.user != null
                                  ? NetworkImage(
                                      user.user!.profilePicture,
                                    )
                                  : null,
                            ),
                          ),
                          // MaterialButton(
                          //   child: 'Set Winner'.text,
                          //   color: Get.theme.primaryColor,
                          //   textColor: Colors.white,
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(10),
                          //   ),
                          //   minWidth: double.infinity,
                          //   onPressed: () {},
                          // ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
