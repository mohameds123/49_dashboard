import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/helper/infinite_scroll_pagination/src/core/paged_child_builder_delegate.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/ui/paged_list_view.dart';
import '../../../../data/model/dynamic/dynamic_ad_model.dart';
import '../controllers/review_ads_controller.dart';
import '../widget/dynamic_ad_card.dart';

class ReviewAdsView extends GetView<ReviewAdsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Ads'),
        centerTitle: true,
      ),
      body: PagedListView.separated(
        pagingController: controller.adsPagingController,
        builderDelegate: PagedChildBuilderDelegate<DynamicAdModel>(
            itemBuilder: (context, item, index) => DynamicAdCard(
                  dynamicAdModel: item,
                  onApproveClick: () => controller.showApproveAdDialog(
                      item, item.pictures, false),
                  onDeclineClick: () =>
                      controller.showDeclineAdDialog(item, false),
                )),
        separatorBuilder: (_, index) => Divider(),
      ),
    );
  }
}
