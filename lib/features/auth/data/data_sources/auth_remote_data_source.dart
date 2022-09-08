import 'package:firebase_auth/firebase_auth.dart';
import '../models/login_model.dart';

abstract class LoginRemoteDataSource {
  Future<LoginModel> postConcreteLogin(String verificationId,String code);
  Future<String> getConcreteSendCode(String number);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final FirebaseAuth client;

  LoginRemoteDataSourceImpl({required this.client});

  @override
  Future<String> getConcreteSendCode(String number) async{
    return (await client.signInWithPhoneNumber(number)).verificationId;
  }

  @override
  Future<LoginModel> postConcreteLogin(String id, String code) async {
    var credential = PhoneAuthProvider.credential(verificationId: id, smsCode: code);
    var res = await client.signInWithCredential(credential);
    return LoginModel.fromJson({"user": res.user});
  }
}