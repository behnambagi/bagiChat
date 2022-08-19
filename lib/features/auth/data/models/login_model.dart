import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/login.dart';

class LoginModel extends Login {
  const LoginModel({User? user}) : super(user);

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(user: json['user']);
  }
}
