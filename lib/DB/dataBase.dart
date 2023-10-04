import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/myUser.dart';
import 'package:chat_app/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyDataBase {
  static CollectionReference<MyUser> getMyUsersCollection() {
    var usersCollection = FirebaseFirestore.instance
        .collection('users')
        .withConverter<MyUser>(
        fromFirestore: (snapshot, _) =>
            MyUser.fromFireStore(snapshot.data()!),
        toFirestore: (user, _) => user.toFireStore());
    return usersCollection;
  }

  static Future<MyUser?> insertUser(MyUser user) async {
    try {
      var usersCollection = getMyUsersCollection();
      await usersCollection.doc(user.id).set(user);
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<MyUser?> getUserById(String id) async {
    try {
      var usersCollection = getMyUsersCollection();
      var user = await usersCollection.doc(id).get();
      if (user.exists) {
        return user.data();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static CollectionReference<Room> getRoomsCollection() {
    var roomsCollection = FirebaseFirestore.instance
        .collection(Room.collectionName)
        .withConverter<Room>(
        fromFirestore: (snapshot, _) =>
            Room.fromFireStore(snapshot.data()!),
        toFirestore: (room, _) => room.toFireStore());
    return roomsCollection;
  }

  static Future<Room?> insertRoom(Room room) async {
    try {
      var roomsCollection = getRoomsCollection();
      DocumentReference docRef = await roomsCollection.add(room);
      room.roomId = docRef.id;
      await docRef.update({'roomId': room.roomId});

      return room;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<List<Room>> getRooms() async {
    var roomsCollection = getRoomsCollection();
    var rooms = await roomsCollection.get();
    List<Room> roomsList = rooms.docs.map((doc) => doc.data()).toList();
    return roomsList;
  }

  static CollectionReference<Message> getMessagesCollection(String id) {
    var messagesCollection = FirebaseFirestore.instance
        .collection(Room.collectionName)
        .doc(id)
        .collection(Message.collectionName)
        .withConverter<Message>(
            fromFirestore: (snapshot, _) =>
                Message.fromFireStore(snapshot.data()!),
            toFirestore: (message, _) => message.toFireStore());
    return messagesCollection;
  }

  static Future<Message?> sendMessage(Message message) async {
    try {
      var messagesCollection = getMessagesCollection(message.roomId ?? '');
      DocumentReference docRef = await messagesCollection.add(message);
      await docRef.update({'messageId': docRef.id});
      return message;
    } catch (e) {
      return null;
    }
  }

  static Stream<QuerySnapshot<Message>> getMessages(String roomId) {
    var messagesCollection =
        getMessagesCollection(roomId).orderBy('messageTime', descending: true);
    return messagesCollection.snapshots();
  }
}
