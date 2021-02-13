import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin MessagesMixin on GetxController {
  void messageListener(Rx<MessageModel> message) {
    ever<MessageModel>(
      message,
      (model) async {
        if (model != null) {
          Get.snackbar(
            model.title,
            model.message,
            colorText: Colors.white,
            backgroundColor: model.type.color(),
          );
        }
      },
    );
  }
}

enum MessageType {
  error,
  info,
  success,
}

class MessageModel {
  final String title;
  final String message;
  final MessageType type;

  MessageModel(this.title, this.message, this.type);
}

extension MessageTypeColorExtension on MessageType {
  Color color() {
    switch (this) {
      case MessageType.error:
        return Color(0XFFF9461C);
        break;
      case MessageType.info:
        return Color(0XFF0086D6);
        break;
      case MessageType.success:
        return Color(0XFF43D787);
        break;
      default:
        return Colors.black38;
    }
  }
}
