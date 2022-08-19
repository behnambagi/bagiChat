import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends Equatable {
  final User? user;

  const Login(this.user);

  @override
  List get props => [user];
}

