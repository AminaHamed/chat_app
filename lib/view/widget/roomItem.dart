import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../model/room.dart';

class RoomItem extends StatelessWidget {
  List<Room> list;

  RoomItem(this.list, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return GridTile(
          child: Container(
            padding:
                const EdgeInsets.only(top: 15, bottom: 10, left: 5, right: 5),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                AppColors.primaryColor,
                Colors.purple,
                Colors.blueAccent,
              ]),
              color: Colors.blueAccent,
              shape: BoxShape.circle,
            ),
            child: Column(
              children: [
                Text(list[index].name),
                const SizedBox(
                  height: 2,
                ),
                ClipOval(
                    child: Image.asset(
                  'assets/images/${list[index].image}',
                  width: 80,
                  height: 80,
                  fit: BoxFit.fill,
                )),
                Text(list[index].description),
              ],
            ),
          ),
        );
      },
    );
  }
}
