import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';
import '../../../../data/model/dynamic/dynamic_ad_model.dart';
import '../../../../routes/app_pages.dart';

class DynamicAdCard extends StatelessWidget {
  final DynamicAdModel dynamicAdModel;

  final VoidCallback? onDeleteClick;
  final VoidCallback? onDeclineClick;
  final VoidCallback? onApproveClick;

  final VoidCallback? onDelete;
  final VoidCallback? onBlock;

  const DynamicAdCard({
    Key? key,
    required this.dynamicAdModel,
    this.onDeclineClick,
    this.onDeleteClick,
    this.onApproveClick,
    this.onBlock,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 150,
            width: double.infinity,
            child: GestureDetector(
              onTap: () => Get.toNamed(
                Routes.SINGLE_AD_DETAILS,
                arguments: dynamicAdModel,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xfff6f6f6),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.red),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 150,
                      width: Get.width * .5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              right: 0,
                              left: 0,
                              bottom: 0,
                              child: Image(
                                image: NetworkImage(
                                  dynamicAdModel.pictures.isNotEmpty ? dynamicAdModel.pictures.first : '',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Row(
                              children: [
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Icon(
                                    dynamicAdModel.isPremium
                                        ? Icons.star_rounded
                                        : Icons.star_border,
                                    color: Colors.yellow,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(.8),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: dynamicAdModel.timeAgo.text
                                          .color(Colors.white)
                                          .bold
                                          .size(12),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (dynamicAdModel.mainCategoryName ?? '')
                                .text
                                .bold
                                .color(Colors.red)
                                .size(12),
                            const SizedBox(height: 8),
                            (dynamicAdModel.subCategoryName ?? '')
                                .text
                                .bold
                                .size(12)
                                .color(Get.theme.primaryColor),
                            const SizedBox(
                              height: 8,
                            ),
                            dynamicAdModel.title.text
                                .size(12)
                                .maxLine(3)
                                .overflowEllipsis,
                            const Spacer(),
                            if (dynamicAdModel.props.isNotEmpty)
                              dynamicAdModel.props.first.value.text.bold
                                  .size(16)
                                  .black,
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (onDeleteClick != null)
                MaterialButton(
                  onPressed: onDeleteClick,
                  child: 'Delete'.text,
                  textColor: Colors.white,
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              if (onDeclineClick != null)
                MaterialButton(
                  onPressed: onDeclineClick,
                  child: 'Decline'.text,
                  textColor: Colors.white,
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              if (onApproveClick != null)
                MaterialButton(
                  onPressed: onApproveClick,
                  child: 'Approve'.text,
                  textColor: Colors.white,
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              if (onDelete != null)
                MaterialButton(
                  onPressed: onDelete,
                  child: 'Delete'.text,
                  textColor: Colors.white,
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              if (onBlock != null)
                MaterialButton(
                  onPressed: onBlock,
                  child: 'Block'.text,
                  textColor: Colors.white,
                  color: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
