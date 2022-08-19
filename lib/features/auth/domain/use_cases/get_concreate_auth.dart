import 'package:bagi_chat/features/auth/domain/entities/login.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/auth_repository.dart';

class GetConcreteSendCode implements UseCase<String, ParamsSendCode> {
  final AuthRepository repository;

  GetConcreteSendCode(this.repository);

  @override
  Future<Either<Failure, String>> call(ParamsSendCode params) async {
    return await repository.getConcreteSendCode(params.number);
  }
}
class PostConcreteLogin implements UseCase<Login, VerifyLoginParams> {
  final AuthRepository repository;

  PostConcreteLogin(this.repository);

  @override
  Future<Either<Failure, Login>> call(VerifyLoginParams params) async {
    return await repository.postConcreteLogin(params);
  }
}

class ParamsSendCode extends Equatable {
  final String number;

  const ParamsSendCode({required this.number});

  @override
  List<Object> get props => [number];
}