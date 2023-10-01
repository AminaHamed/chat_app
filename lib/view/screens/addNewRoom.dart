import 'package:chat_app/core/app_colors.dart';
import 'package:chat_app/model/room.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/dialog_utils.dart';
import '../../viewModel/addNewRoomViewModel.dart';
import '../widget/custom_button.dart';

class AddNewRoom extends StatefulWidget {
  const AddNewRoom({Key? key}) : super(key: key);

  @override
  State<AddNewRoom> createState() => _AddNewRoomState();
}

class _AddNewRoomState extends State<AddNewRoom>
    implements AddNewRoomNavigator {
  late AddNewRoomViewModel viewModel;
  var formKey = GlobalKey<FormState>();
  Room selectedRoom = roomsList[0];

  @override
  void initState() {
    viewModel = AddNewRoomViewModel();
    viewModel.navigator = this;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.typeName = selectedRoom.type;
    viewModel.typeImage = selectedRoom.image;
    return ChangeNotifierProvider(
      create: (_) {
        return viewModel;
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.primaryColor,
        body: Card(
          margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          elevation: 10,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    ' Room Name:',
                    style: TextStyle(color: AppColors.secondaryColor),
                  ),
                  TextFormField(
                    controller: viewModel.nameController,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Room Name Can't be Empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    ' Room Type:',
                    style: TextStyle(color: AppColors.secondaryColor),
                  ),
                  DropdownButton<Room>(
                    value: selectedRoom,
                    items: roomsList.map((Room room) {
                      return DropdownMenuItem<Room>(
                        value: room,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/${room.image}',
                              width: 80,
                              height: 80,
                            ),
                            Text(room.name),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (Room? newSelectedRoom) {
                      viewModel.typeName = selectedRoom.type;
                      viewModel.typeImage = selectedRoom.image;
                      setState(() {
                        selectedRoom = newSelectedRoom!;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    ' Room Description:',
                    style: TextStyle(color: AppColors.secondaryColor),
                  ),
                  TextFormField(
                    controller: viewModel.desController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: "Add",
                    onPressed: () {
                      if (formKey.currentState!.validate() == false) {
                        return;
                      }
                      viewModel.addNewRoom();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void hideLoading() {
    DialogUtils.hideDialog(context);
  }

  @override
  void showLoading() {
    DialogUtils.showProgressDialog(context, 'Loading');
  }

  @override
  void showMessage(String message) {
    DialogUtils.showMessage(context, message);
  }

  @override
  void goBack() {
    Navigator.pop(context);
  }
}
