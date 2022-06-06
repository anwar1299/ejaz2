import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String? email;
  String? level;
  String? name;
  int? number;
  String? role;
  String? image;
  String? uid;
  // firebase timestamp
  DateTime? dob;
  // list of strings skills
  List<String>? skills;
  // list of strings interests
  List<String>? interests;
  // natonality
  String? natonality;
  bool? isActive;

  UserData(
      {this.email,
      this.level,
      this.name,
      this.number,
      this.role,
      this.dob,
      this.skills,
      this.interests,
      this.natonality,
      this.uid,
      this.image,
      this.isActive});

  factory UserData.fromJson(Map<String, dynamic> json) {
    final Timestamp timestamp = json['dob'];
    final DateTime date = timestamp.toDate();
    return UserData(
      email: json['email'],
      level: json['level'],
      name: json['name'],
      number: json['number'],
      uid: json['id'],
      role: json['role'],
      image: json['image'],
      isActive: json['isActive'] == null ? true : json['isActive'],
      dob: date,
      skills: json["skills"] == null
          ? []
          : List<String>.from(json["skills"].map((x) => x)),
      interests: json["interests"] == null
          ? []
          : List<String>.from(json["interests"].map((x) => x)),
      natonality: json['natonality'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['email'] = this.email;
    data['level'] = this.level;
    data['name'] = this.name;
    data['number'] = this.number;
    data['role'] = this.role;
    data['id'] = this. uid;
    return data;
  }
}
