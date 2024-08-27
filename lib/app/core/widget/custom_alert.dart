import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';

class CustomAlert {
  CustomAlert._();

  static void customLoadingDialog({bool dismissible = false}) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return WillPopScope(
          onWillPop: () async {
            return dismissible;
          },
          child: Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 0,
                contentPadding: const EdgeInsets.only(
                  top: 8,
                  bottom: 5,
                  left: 10,
                  right: 10,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    "loading".text.bold,
                    const SizedBox(
                      height: 33,
                    ),
                    const CircularProgressIndicator.adaptive(),
                    const SizedBox(
                      height: 33,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 250),
      barrierDismissible: true,
      barrierLabel: '',
      context: Get.context!,
      pageBuilder: (context, animation, secondaryAnimation) {
        return const SizedBox.shrink();
      },
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar({
    required String msg,
  }) {
    return ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static Future<int?> customAskDialog({
    String? title,
    required String message,
    bool dismissible = true,
  }) async {
    return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return WillPopScope(
          onWillPop: () async {
            return dismissible;
          },
          child: Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                title: title?.text.alignCenter,
                contentPadding: EdgeInsets.zero.copyWith(
                  top: title == null ? 20 : 8,
                  bottom: 5,
                  left: 10,
                  right: 10,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    message.text.alignCenter,
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, -1),
                          child: "cancel".text.size(15),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, 1),
                          child: "ok".text.size(15),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 250),
      barrierDismissible: true,
      barrierLabel: '',
      context: Get.context!,
      pageBuilder: (context, animation, secondaryAnimation) {
        return const SizedBox.shrink();
      },
    );
  }

  static void showError(String err) {

    Get.snackbar(
      'Error',
      err.contains('connectTimeout') ? 'No Internet Connection' : err,
      duration: const Duration(seconds: 5),
      borderRadius: 10,
      colorText: Colors.white,
      backgroundColor: Colors.red,
    );
  }

  static void customAlertDialog({
    Function()? onPress,
    required String errorMessage,
    bool dismissible = true,
  }) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return WillPopScope(
          onWillPop: () async {
            return dismissible;
          },
          child: Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                contentPadding: EdgeInsets.zero
                    .copyWith(top: 20, bottom: 5, left: 10, right: 10),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      errorMessage.text.alignCenter,
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        child: ElevatedButton(
                          onPressed: onPress ?? () => Navigator.pop(context),
                          child: "ok".text,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 250),
      barrierDismissible: true,
      barrierLabel: '',
      context: Get.context!,
      pageBuilder: (context, animation, secondaryAnimation) {
        return const SizedBox.shrink();
      },
    );
  }

  static Future<int?> customChooseDialog({
    String? title,
    required List<String> data,
  }) async {
    return showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  title.text.black.size(19)
                else
                  const SizedBox(),
                ...data.map(
                  (e) => InkWell(
                    onTap: () {
                      Navigator.pop(context, data.indexOf(e));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: e.text,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomAskButtonSheetModel {
  final String title;
  final int id;
  final IconData? icon;

  CustomAskButtonSheetModel({required this.title, required this.id, this.icon});
}
