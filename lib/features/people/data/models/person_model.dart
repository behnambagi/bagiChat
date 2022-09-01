import '../../domain/entities/person.dart';

class PersonModel extends Person {
  const PersonModel({required String uid,
    required String name, required String phone,
    required String status, String? picture})
      : super(uid,name, phone, status, picture );


  Map<String, dynamic> toMap(){
    return {
      "uid": uid,
      "name": name,
      "phone": phone,
      "status": status,
      "picture": picture
    };
  }

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(picture: json['picture'], name: json['name'],
        status: json['status'], phone: json['phone'], uid: json['uid']);
  }
}
