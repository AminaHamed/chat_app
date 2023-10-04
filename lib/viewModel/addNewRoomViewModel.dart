import 'package:chat_app/core/base/base.dart';
import 'package:chat_app/model/room.dart';
import 'package:flutter/material.dart';

import '../DB/dataBase.dart';

abstract class AddNewRoomNavigator extends BaseNavigator {
  void goBack();
}

class AddNewRoomViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController desController = TextEditingController();
  AddNewRoomNavigator? navigator;
  late String typeName;
  late String typeImage;

  Future<void> addNewRoom() async {
    try {
      navigator?.showLoading();
      var data = await MyDataBase.insertRoom(Room(
          name: nameController.text,
          description: desController.text,
          type: typeName,
          image: typeImage));
      notifyListeners();

      nameController.clear();
      desController.clear();
      navigator?.hideLoading();

      if (data != null) {
        navigator?.goBack();
      } else {
        navigator?.showMessage("Error Can't insert Room");
      }
    } catch (e) {
      navigator?.hideLoading();
      navigator?.showMessage(e.toString());
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    desController.dispose();
    super.dispose();
  }
}
