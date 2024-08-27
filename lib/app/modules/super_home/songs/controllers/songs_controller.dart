import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textless/textless.dart';

import '../../../../core/constants.dart';
import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/core/paging_controller.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/song_model.dart';

class SongsController extends GetxController {
  //final audioPlayer = AudioPlayer();

  late final songsPagingController =
      PagingController<int, SongModel>(firstPageKey: 1)
        ..addPageRequestListener(_fetchSongsPage);

  Future<void> _fetchSongsPage(int pageKey) async {
    try {
      final result =
          await CustomDio().get('super-admin/reel-songs?page=$pageKey');

      final newItemsResult =
          ((result.data as Map<String, dynamic>)['data'] as List)
              .map((e) => SongModel.fromMap(e as Map<String, dynamic>))
              .toList();

      final newItems = newItemsResult
          .where((e) => !songsPagingController.itemList.contains(e))
          .toList();

      final isLastPage = newItemsResult.isEmpty;
      if (isLastPage) {
        songsPagingController.appendLastPage(newItems);
      } else {
        songsPagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (error) {
      songsPagingController.error = error;
    }
  }

  void showAddSheet() {
    String name = '';
    String desc = '';
    String thumb = '';
    String songPath = '';

    Get.bottomSheet(
      Material(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                CustomTextFieldWithBackground(
                  label: 'Name',
                  onChange: (v) => name = v,
                ),
                SizedBox(height: 10),
                CustomTextFieldWithBackground(
                  label: 'Description',
                  onChange: (v) => desc = v,
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: ValueBuilder<String?>(
                    onUpdate: (v) => thumb = v!,
                    builder: (value, update) => Padding(
                      padding: const EdgeInsetsDirectional.only(start: 10),
                      child: value == null
                          ? IconButton(
                              onPressed: () async {
                                final image = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                if (image != null) {
                                  update(image.path);
                                }
                              },
                              icon: Icon(Icons.image),
                            )
                          : InkWell(
                              onTap: () async {
                                final image = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                if (image != null) {
                                  update(image.path);
                                }
                              },
                              child: Image.file(
                                File(value),
                                height: 50,
                                width: 50,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: ValueBuilder<String?>(
                    onUpdate: (v) => songPath = v!,
                    builder: (value, update) => Padding(
                      padding: const EdgeInsetsDirectional.only(start: 10),
                      child: IconButton(
                        onPressed: () async {
                        /*  await audioPlayer.pause();
                          audioPlayer.dispose();
                          final song = await FilePicker.platform.pickFiles(
                            dialogTitle: 'Pick a Song',
                            allowMultiple: false,
                            type: FileType.audio,
                          );*/
                        //  if (song != null && song.files.isNotEmpty) {
                            /*await audioPlayer
                                .play(DeviceFileSource(song.files.first.path!));
                            update(song.files.first.path);*/
                         // }
                        },
                        icon: Icon(Icons.audio_file,
                            color: value != null ? Colors.green : null),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                MaterialButton(
                  child: 'Add'.text,
                  color: Colors.green,
                  disabledColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minWidth: Get.width,
                  textColor: Colors.white,
                  onPressed: () {
                   /* audioPlayer.pause();
                    if (name.isNotEmpty &&
                        desc.isNotEmpty &&
                        thumb.isNotEmpty &&
                        songPath.isNotEmpty) {
                      addSong(name, desc, thumb, songPath);
                    } else {
                      CustomAlert.showError('Please Fill All Fields');
                    }*/
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<double> getFileDuration(String mediaPath) async {
    //final mediaInfoSession = await FFprobeKit.getMediaInformation(mediaPath);
    //final mediaInfo = mediaInfoSession.getMediaInformation()!;
    return 0;
    //return double.parse(mediaInfo.getDuration()!) * 1000;
  }

  void addSong(String name, String desc, String thumb, String songPath) async {
    try {
      Get.back();
      CustomAlert.customLoadingDialog();

      String? songUrlPath = await AppConstants.spaceBucket
          .uploadFile(songPath, 'image/jpg', 'jpg');

      String? thumbUrlPath =
          await AppConstants.spaceBucket.uploadFile(thumb, 'image/jpg', 'jpg');

      final result = await CustomDio(enableLog: true).post(
        'super-admin/reel-songs',
        body: {
          'name': name,
          'desc': desc,
          'duration': await getFileDuration(songPath),
          'thumb_url': thumbUrlPath,
          'play_url': songUrlPath,
        },
      );
      songsPagingController.addItem(SongModel.fromMap(result.data['data']));
      Get.back();
      CustomAlert.snackBar(msg: 'Successfully Upload Song');
    } catch (e) {
      Get.back();
      CustomAlert.showError(e.toString());
    }
  }

  Future<void> runSong(SongModel song) async {
   /* if (audioPlayer.state == PlayerState.playing) {
      await audioPlayer.stop();
    } else {
      final file = await DefaultCacheManager().getSingleFile(song.playUrl);

      song.playPath = file.path;

      audioPlayer.play(
        BytesSource(
          await file.readAsBytes(),
        ),
      );
    }*/
  }

  void showDeleteSongDialog(SongModel song) {
    Get.defaultDialog(
      title: 'Confirm!',
      middleText: 'Are you sure you want to delete Admin (${song.name})?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Colors.white,
      onConfirm: () => deleteSong(song),
    );
  }

  void deleteSong(SongModel song) async {
    try {
      Get.back();
      await CustomDio().delete('super-admin/reel-songs/${song.id}');

      songsPagingController.removeItem(song);
      CustomAlert.snackBar(msg: 'Success Song Deleted.');
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  @override
  void onClose() {
 //   audioPlayer.dispose();
    songsPagingController.dispose();
    super.onClose();
  }
}
