import 'package:equatable/equatable.dart';

class Person extends Equatable {
  final String uid;
  final String name;
  final String phone;
  final String status;
  final String? picture;

  const Person(this.uid, this.name, this.phone, this.status, this.picture);

  @override
  List get props => [uid, name, phone, status, picture];
}

