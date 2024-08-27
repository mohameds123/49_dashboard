import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/enums.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/core/paged_child_builder_delegate.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/ui/paged_list_view.dart';
import '../../../../data/model/running_cost_model.dart';
import '../controllers/running_cost_controller.dart';

class RunningCostView extends GetView<RunningCostController> {
  const RunningCostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Running Cost'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            ValueBuilder<int?>(
              onUpdate: controller.onTypeChanged,
              builder: (value, update) => DropdownButton<int>(
                isExpanded: true,
                hint: 'Type'.text,
                items: List.generate(
                  RunningCostType.length,
                  (index) => DropdownMenuItem(
                    child: RunningCostType[index].text,
                    value: index,
                  ),
                ),
                onChanged: update,
                value: value,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Total'.text.bold.size(16),
                Obx(
                  () => controller.total.value.toString().text.size(20),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: PagedListView(
                pagingController: controller.costsPagingController,
                builderDelegate: PagedChildBuilderDelegate<RunningCostModel>(
                  itemBuilder: (context, item, index) => Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RunningCostType[item.type].text.bold.size(18),
                          SizedBox(height: 5),
                          item.cost.toString().text.color(Colors.red).size(18),
                          SizedBox(height: 5),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              item.createdAt.toString().text.size(18),
                              IconButton(
                                onPressed: () =>
                                    controller.showDeleteConfirmDialog(item),
                                icon: Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.showAddDialog,
        backgroundColor: Get.theme.primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }
}
