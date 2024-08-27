import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/helper/infinite_scroll_pagination/src/core/paged_child_builder_delegate.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/ui/paged_list_view.dart';
import '../../../../data/model/dynamic/dynamic_ad_model.dart';
import '../../../admin/review_ads/widget/dynamic_ad_card.dart';
import '../controllers/dynamic_ads_controller.dart';

class DynamicAdsView extends GetView<DynamicAdsController> {
  const DynamicAdsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ads'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async => controller.adsPagingController.refresh(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ValueBuilder<String?>(
                onUpdate: controller.onMainCategoryChanged,
                builder: (value, update) => Obx(
                      () => DropdownButton(
                      hint: 'Main Category'.text,
                      isExpanded: true,
                      value: value,
                      items: controller.mainCategories
                          .map(
                            (e) => DropdownMenuItem(
                            value: e.id, child: e.nameEn.text),
                      )
                          .toList(),
                      onChanged: update),
                ),
              ),
            ),
            Expanded(
              child: PagedListView.separated(
                pagingController: controller.adsPagingController,
                builderDelegate: PagedChildBuilderDelegate<DynamicAdModel>(
                  itemBuilder: (context, item, index) => DynamicAdCard(
                    dynamicAdModel: item,
                    onBlock: () => controller.showLockDialog(item.userId),
                    onDelete: () => controller.showDeleteConfirmDialog(item),
                    //   onDeclineClick: () => controller.showDeclineAdDialog(item, false),
                  ),
                ),
                separatorBuilder: (_, index) => Divider(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
