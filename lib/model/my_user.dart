class MyUser {
  /// 1-CollectionName
  static const String collectionName = 'users';

  /// 2-Attributes
  String id;
  String name;
  String email;

  /// 3-Constructor
  MyUser({required this.id, required this.name, required this.email});

  /// 4-json => object
  MyUser.fromFirestore(Map<String, dynamic> data)
    : this(id: data['id'], name: data['name'], email: data['email']);

  /// 5-object => json
  Map<String, dynamic> toFireStore() {
    return {'id': id, 'name': name, 'email': email};
  }
}
