class Room {
  static const String collectionName = 'Rooms';
  String roomId;
  final String name;
  String description;
  final String image;
  String type;

  //TODO list of Message

  Room(
      {this.roomId = '',
      required this.name,
      this.description = '',
      required this.image,
      required this.type});

  Map<String, dynamic> toFireStore() {
    return {
      'roomId': roomId,
      'roomName': name,
      'description': description,
      'image': image,
      'type': type,
    };
  }

  Room.fromFireStore(Map<String, dynamic> data)
      : this(
          roomId: data['roomId'],
          name: data['roomName'],
          description: data['description'],
          image: data['image'],
          type: data['type'],
        );
} //Room

final List<Room> roomsList = [
  Room(name: 'Music', image: 'music1.png', type: 'Music'),
  Room(name: 'Movies', image: 'movie.jpg', type: 'Movies'),
  Room(name: 'Sport', image: 'sports.JPG', type: 'Sport'),
];

// class RoomCategory{
//   final String catId;
//   final String name;
//   final String image;
//   RoomCategory(this.catId, this.name, this.image);
//
// }
