import 'package:chat_app/DB/dataBase.dart';
import 'package:chat_app/core/base/base.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/sharedData.dart';
import 'package:flutter/material.dart';

abstract class MyNavigator extends BaseNavigator {}

class ChatRoomViewModel extends BaseViewModel<MyNavigator> {
  TextEditingController controller = TextEditingController();

  Future<void> send(String roomID) async {
    Message message = Message(
        roomId: roomID,
        senderId: SharedData.userData?.id ?? "",
        senderName: SharedData.userData?.userName ?? "",
        messageContent: controller.text,
        messageTime: DateTime.now());
    Message? data = await MyDataBase.sendMessage(message);
    if (data != null) {
      controller.clear();
    } else {
      navigator?.showMessage(
          "Can't insert message\ncheck internet connection or\ntry again later. ");
    }
  }
}
