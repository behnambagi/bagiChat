

import 'package:bagi_chat/features/auth/domain/entities/login.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, Login>> postConcreteLogin(VerifyLoginParams loginParams);
  Future<Either<Failure, String>> getConcreteSendCode(String number);
}

class VerifyLoginParams extends Equatable{
  final String credentialId;
  final String code;
  const VerifyLoginParams({required this.credentialId, required this.code});

  @override
  List get props => [credentialId, code];

}

