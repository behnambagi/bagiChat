import 'package:bagi_chat/core/errors/failure.dart';
import 'package:bagi_chat/features/auth/domain/entities/login.dart';
import 'package:bagi_chat/features/auth/domain/repositories/auth_repository.dart';
import '../../../../core/errors/exeptions.dart';
import '../data_sources/auth_remote_data_source.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository {

  final LoginRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> getConcreteSendCode(String number) async{
    try {
      var res = await remoteDataSource.getConcreteSendCode(number);
      return Right(res);
    } on ServerException {
      return const Left(ServerFailure("server"));
    }
  }

  @override
  Future<Either<Failure, Login>> postConcreteLogin(
      VerifyLoginParams loginParams) async {
    try {
      var res = await remoteDataSource.postConcreteLogin(
          loginParams.credentialId, loginParams.code);
      return Right(res);
    } on ServerException {
      return const Left(ServerFailure("server"));
    }
  }
}