import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../../../core/app_state.dart';
import '../controllers/message_controller.dart';
import '../widget/message_widget.dart';

class MessageView extends GetView<MessageController> {
  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => ListView.separated(
          itemCount: controller.messages.length,
          itemBuilder: (_, index) {
            return  MessageWidget(
              message: controller.messages[index],
            );
          },
          separatorBuilder: (_, __) => Divider(),
        ),
      ),
    );
  }
}
