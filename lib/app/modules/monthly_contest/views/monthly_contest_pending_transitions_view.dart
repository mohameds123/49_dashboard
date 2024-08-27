import 'package:flutter/material.dart';
import 'package:textless/textless.dart';
import '../controllers/monthly_contest_controller.dart';
import 'package:get/get.dart';

class MonthlyContestPendingTransitionsView
    extends GetView<MonthlyContestController> {
  const MonthlyContestPendingTransitionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Transactions'),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.pendingTransitions.isEmpty
            ? Center(child: 'No Pending Transactions'.text.black.alignCenter)
            : ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: controller.pendingTransitions.length,
                itemBuilder: (_, index) {
                  final item = controller.pendingTransitions[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(item.user!.profilePicture),
                          ),
                          title: Text(item.user!.fullName),
                          subtitle: Text(item.phone),
                          trailing: Text(item.date),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: MaterialButton(
                                child: 'Accept'.text,
                                color: Colors.green,
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minWidth: double.infinity,
                                onPressed: () =>
                                    controller.showAcceptTransitionDialog(item),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: MaterialButton(
                                child: 'Delcine'.text,
                                color: Colors.red,
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minWidth: double.infinity,
                                onPressed: () => controller
                                    .showDeclineTransitionDialog(item),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
