import 'package:chat_app/core/app_colors.dart';
import 'package:chat_app/model/message.dart';
import 'package:flutter/material.dart';

class SenderWidget extends StatelessWidget {
  const SenderWidget({Key? key, required this.message}) : super(key: key);
  final Message? message;

  @override
  Widget build(BuildContext context) {
    int? hour = message?.messageTime?.hour;
    int? minute = message?.messageTime?.minute;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                child: Text("${message?.messageContent}"),
              ),
            ),
          ],
        ),
        Text(
          "$hour:$minute",
          style: const TextStyle(color: Colors.black12, fontSize: 18),
        ),
      ],
    );
  }
}

class SecondWidget extends StatelessWidget {
  const SecondWidget({Key? key, required this.message}) : super(key: key);
  final Message? message;

  @override
  Widget build(BuildContext context) {
    int? hour = message?.messageTime?.hour;
    int? minute = message?.messageTime?.minute;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("${message?.senderName}:",
                style: const TextStyle(color: Colors.black38)),
          ],
        ),
        const SizedBox(height: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                decoration: const BoxDecoration(
                    color: Color(0xffe2e2e2),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                child: Text("${message?.messageContent}",
                    style: const TextStyle(color: Colors.black45)),
              ),
            ),
          ],
        ),
        Text(
          "$hour:$minute",
          style: const TextStyle(color: Colors.black12, fontSize: 18),
        ),
      ],
    );
  }
}
