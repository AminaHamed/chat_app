class MyUser {
  String id;
  String userName;
  String email;
  String password;

  MyUser(
      {required this.id,
      required this.userName,
      required this.email,
      required this.password});

  Map<String, dynamic> toFireStore() {
    return {'id': id, 'name': userName, 'email': email, 'password': password};
  }

  MyUser.fromFireStore(Map<String, dynamic> data)
      : this(
            id: data['id'],
            userName: data['name'],
            email: data['email'],
            password: data['password']);
}
