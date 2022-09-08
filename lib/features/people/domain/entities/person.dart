import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Person extends Equatable {
  final String uid;
  final String name;
  final String phone;
  final String status;
  final String? picture;

  const Person(this.uid, this.name, this.phone, this.status, this.picture);

  Widget get avatar =>
      picture != null ? Image.network(picture!) : Text(name[0]);

  Widget circleAvatar(double size) => CircleAvatar(
      radius: size,
      backgroundImage: picture != null ? NetworkImage(picture!) : null,
      child: picture == null ? Text(name[0]) : null);

  @override
  List get props => [uid, name, phone, status, picture];
}
