import 'dart:typed_data';

class UserModel {
  final String uid;
  final String name;
  final String profilePic;
  final String phoneNumber;
  final List<String> groupId;
  final bool isOnline;
  final bool isSelect;

  UserModel({
    required this.uid,
    required this.name,
    required this.profilePic,
    required this.phoneNumber,
    required this.groupId,
    required this.isOnline,
    required this.isSelect,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      uid: json['uid'],
      name: json['name'],
      profilePic: json['profilePic'],
      phoneNumber: json['phoneNumber'],
      groupId: List<String>.from(json['groupId']),
      isOnline: json['isOnline'] ?? false,
      isSelect: json['isSelect'] ?? false,);

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'profilePic': profilePic,
        'phoneNumber': phoneNumber,
        'groupId': groupId,
        'isOnline': isOnline,
        'isSelect': isSelect
      };
}

class User {
  final String uid;
  final String name;
  final Uint8List? profilePic;
  final String phoneNumber;

  User({
    required this.uid,
    required this.name,
    required this.profilePic,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    uid: json['uid'],
    name: json['name'],
    profilePic: json['profilePic'],
    phoneNumber: json['phoneNumber'],
  );

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'profilePic': profilePic,
    'phoneNumber': phoneNumber,
  };
}
