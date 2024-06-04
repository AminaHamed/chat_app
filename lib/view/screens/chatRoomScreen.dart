import 'package:chat_app/DB/dataBase.dart';
import 'package:chat_app/core/app_colors.dart';
import 'package:chat_app/core/base/base.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/sharedData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/room.dart';
import '../../viewModel/chatRoomViewModel.dart';
import '../widget/chatWidget.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({Key? key}) : super(key: key);

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState
    extends BaseState<ChatRoomScreen, ChatRoomViewModel> {
  @override
  ChatRoomViewModel initViewModel() {
    return ChatRoomViewModel();
  }

  @override
  Widget build(BuildContext context) {
    Room room = ModalRoute.of(context)?.settings.arguments as Room;
    return ChangeNotifierProvider(
      create: (_) {
        return viewModel;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text(
            "Room of ${room.name}",
            style: (const TextStyle(fontSize: 20)),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            children: [
              Expanded(
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: StreamBuilder<QuerySnapshot<Message>>(
                      stream: MyDataBase.getMessages(room.roomId),
                      builder: (context, snapshot) {
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
                        List<Message> messageList = snapshot.data?.docs
                                .map((doc) => doc.data())
                                .toList() ??
                            [];

                        return ListView.separated(
                          reverse: true,
                          itemBuilder: (_, index) {
                            return messageList[index].senderId ==
                                    SharedData.userData?.id
                                ? SenderWidget(
                                    message: messageList[index],
                                  )
                                : SecondWidget(
                                    message: messageList[index],
                                  );
                          },
                          itemCount: messageList.length,
                          separatorBuilder: (_, __) {
                            return const SizedBox(height: 5);
                          },
                        );
                      },
                    )),
              ),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                          // maxLines: 6,
                          controller: viewModel.controller,
                          decoration: const InputDecoration(
                              hintText: 'Enter Your Message',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.primaryColor, width: 1),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              )))),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () async {
                      await viewModel.send(room.roomId);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryColor,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      child: const Row(
                        children: [
                          Text('Send'),
                          SizedBox(width: 5),
                          Icon(
                            Icons.send,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
