import 'package:chat_app/DB/dataBase.dart';
import 'package:chat_app/core/app_colors.dart';
import 'package:chat_app/core/app_routes.dart';
import 'package:chat_app/model/sharedData.dart';
import 'package:chat_app/view/widget/roomItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/room.dart';
import '../../viewModel/addNewRoomViewModel.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  late AddNewRoomViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    print("${SharedData.userData?.userName}");
    return ChangeNotifierProvider(
      create: (_) => viewModel = AddNewRoomViewModel(),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).size.height * 0.60,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const Positioned(
                top: 50,
                left: 10,
                right: 10,
                child: Text(
                  'Chat with people who \n share your interests.',
                  style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold, height: 1.5),
                  textAlign: TextAlign.center,
                )),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.20,
                left: 0,
                right: 0,
                bottom: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  child: Column(
                    children: [
                      Expanded(
                        child: Consumer<AddNewRoomViewModel>(
                          builder: (context, newRoomViewModel, child) {
                            return FutureBuilder<List<Room>?>(
                              future: MyDataBase.getRooms(),
                              builder: (_, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasError) {
                                  return const Center(
                                    child: Text('Snapshot Error'),
                                  );
                                }
                                if (snapshot.data!.isEmpty) {
                                  return const Center(
                                    child: Text(
                                      'No Rooms yet',
                                      style: TextStyle(
                                          color: AppColors.secondaryColor),
                                    ),
                                  );
                                }
                                List<Room> list = snapshot.data!;
                                return RoomItem(list);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
        floatingActionButton: const CustomFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }
}

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addNewRoom.name);
        },
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.primaryColor, width: 5.0),
          borderRadius: BorderRadius.circular(30.0), // Adjust the border radius
        ),
        backgroundColor: Colors.white,
        elevation: 10,
        child: const Icon(Icons.add, color: AppColors.primaryColor),
      ),
    );
  }
}
