import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';
import '../../../../core/enums.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/core/paged_child_builder_delegate.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/ui/paged_list_view.dart';
import '../../../../core/widget/video_player_widget.dart';
import '../../../../data/model/app_radio_model.dart';
import '../controllers/app_radio_controller.dart';
import '../widget/auido_item_widget.dart';

class AppRadioView extends GetView<AppRadioController> {
  const AppRadioView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Radio'),
        centerTitle: true,
      ),
      body: ValueBuilder<int?>(
        initialValue: 0,
        builder: (value, update) => Column(
          children: [
            Padding(
               padding: const EdgeInsets.all(8.0),
              child: DropdownButton(
                  isExpanded: true,
                  value: value,
                  items: AppRadioCategories.values
                      .map((e) => DropdownMenuItem(
                          value: e.index,
                          child: e.name.replaceAll('_', '').capitalize!.text))
                      .toList(),
                  onChanged: update),
            ),
            Expanded(
              child: IndexedStack(
                index: value,
                children: [
                  PagedListView(
                    pagingController: controller.categoryOnePagingController,
                    builderDelegate: PagedChildBuilderDelegate<AppRadioModel>(
                      itemBuilder: (context, item, index) => _buildItem(item),
                    ),
                  ),
                  PagedListView(
                    pagingController: controller.categoryTwoPagingController,
                    builderDelegate: PagedChildBuilderDelegate<AppRadioModel>(
                      itemBuilder: (context, item, index) => _buildItem(item),
                    ),
                  ),
                  PagedListView(
                    pagingController: controller.categoryThreePagingController,
                    builderDelegate: PagedChildBuilderDelegate<AppRadioModel>(
                      itemBuilder: (context, item, index) => _buildItem(item),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Get.theme.primaryColor,
        child: Icon(Icons.add),
        onPressed: controller.showAddSheet,
      ),
    );
  }

  Widget _buildItem(AppRadioModel appRadio) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appRadio.type == AppRadioTypes.banner
                ? _buildPictureItem(appRadio)
                : appRadio.type == AppRadioTypes.video
                    ? _buildVideoItem(appRadio)
                    : appRadio.type == AppRadioTypes.text
                        ? _buildTextItem(appRadio)
                        : appRadio.type == AppRadioTypes.voice
                            ? _buildVoiceItem(appRadio)
                            : SizedBox(),
            Row(
              children: [
                IconButton(
                  onPressed: () => controller.showDeleteConfirmDialog(appRadio),
                  icon: Icon(
                    Icons.clear,
                    color: Colors.red,
                  ),
                ),
                IconButton(
                  onPressed: () => controller.showEditSheet(appRadio),
                  icon: Icon(
                    Icons.edit,
                    color: Colors.red,
                  ),
                ),
                const Spacer(),
                '${appRadio.days} Days'.text.bold.size(18),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPictureItem(AppRadioModel appRadio) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: CachedNetworkImage(
            imageUrl: appRadio.picture!,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        ListTile(
          leading: appRadio.user == null
              ? SvgPicture.asset(
                  'assets/images/logo_svg.svg',
                  height: 50,
                  width: 50,
                )
              : CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      CachedNetworkImageProvider(appRadio.user!.profilePicture),
                ),
          title: (appRadio.user == null ? '49 App' : appRadio.user!.fullName)
              .text
              .bold
              .size(20),
          subtitle: appRadio.text != null ? appRadio.text!.text : null,
        ),
      ],
    );
  }

  Widget _buildVideoItem(AppRadioModel appRadio) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: SizedBox(
            height: 200,
            width: double.infinity,
            child: VideoPlayWidget(
              url: appRadio.video!,
            ),
          ),
        ),
        ListTile(
          leading: appRadio.user == null
              ? SvgPicture.asset(
                  'assets/images/logo_svg.svg',
                  height: 50,
                  width: 50,
                )
              : CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      CachedNetworkImageProvider(appRadio.user!.profilePicture),
                ),
          title: (appRadio.user == null ? '49 App' : appRadio.user!.fullName)
              .text
              .bold
              .size(20),
          subtitle: appRadio.text != null ? appRadio.text!.text : null,
        ),
      ],
    );
  }

  Widget _buildTextItem(AppRadioModel appRadio) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                appRadio.text!,
                textStyle: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                speed: const Duration(milliseconds: 100),
              ),
            ],
            totalRepeatCount: 100000000,
            pause: const Duration(milliseconds: 1000),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
          ),
        ),
        ListTile(
          leading: appRadio.user == null
              ? SvgPicture.asset(
                  'assets/images/logo_svg.svg',
                  height: 50,
                  width: 50,
                )
              : CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      CachedNetworkImageProvider(appRadio.user!.profilePicture),
                ),
          title: (appRadio.user == null ? '49 App' : appRadio.user!.fullName)
              .text
              .bold
              .size(20),
          subtitle: appRadio.text != null ? appRadio.text!.text : null,
        ),
      ],
    );
  }

  Widget _buildVoiceItem(AppRadioModel appRadio) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AudioItemWidget(audioUrl: appRadio.voice!, picture: appRadio.picture),
        ListTile(
          leading: appRadio.user == null
              ? SvgPicture.asset(
                  'assets/images/logo_svg.svg',
                  height: 50,
                  width: 50,
                )
              : CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      CachedNetworkImageProvider(appRadio.user!.profilePicture),
                ),
          title: (appRadio.user == null ? '49 App' : appRadio.user!.fullName)
              .text
              .bold
              .size(20),
          subtitle: appRadio.text != null ? appRadio.text!.text : null,
        ),
      ],
    );
  }
}
