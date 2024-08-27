import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../controllers/complaints_controller.dart';

class ComplaintsView extends GetView<ComplaintsController> {
  const ComplaintsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaints'),
        centerTitle: true,
      ),
      body: Obx(
        () => RefreshIndicator.adaptive(
          child: controller.complaints.isEmpty
              ? Center(child: 'No Complaints'.text.black.alignCenter)
              : ListView.builder(
                  itemCount: controller.complaints.length,
                  itemBuilder: (_, index) {
                    final item = controller.complaints[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: (item.user?.firstName ?? '').text,
                          title: item.name.text.bold,
                          subtitle: item.description.text,
                          trailing: item.phone.text,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            child: 'Delete'.text,
                            color: Colors.red,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onPressed: () => controller.showDeleteDialog(item),
                          ),
                        ),
                      ],
                    );
                  },
                ),
          onRefresh: controller.getData,
        ),
      ),
    );
  }
}
