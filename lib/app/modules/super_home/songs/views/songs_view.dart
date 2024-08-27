import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/helper/infinite_scroll_pagination/src/core/paged_child_builder_delegate.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/ui/paged_list_view.dart';
import '../../../../data/model/song_model.dart';
import '../controllers/songs_controller.dart';

class SongsView extends GetView<SongsController> {
  const SongsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reel & Story Songs'),
        centerTitle: true,
      ),
      body: PagedListView(
        pagingController: controller.songsPagingController,
        builderDelegate: PagedChildBuilderDelegate<SongModel>(
          itemBuilder: (context, item, index) => _buildSongWidget(item),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.showAddSheet,
        child: Icon(Icons.add),
        backgroundColor: Get.theme.primaryColor,
      ),
    );
  }

  Widget _buildSongWidget(SongModel song) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: song.thumbUrl,
        width: 50,
        height: 50,
        fit: BoxFit.fill,
      ),
      title: song.name.text,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          song.desc.text,
          const SizedBox(
            height: 3,
          ),
          Text('${(song.duration / 1000).round()} Second')
        ],
      ),
      trailing: IconButton(
          onPressed: () => controller.showDeleteSongDialog(song),
          icon: Icon(Icons.clear)),
      onTap: () => controller.runSong(song),
    );
  }
}
