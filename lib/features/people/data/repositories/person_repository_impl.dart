import 'dart:typed_data';

import 'package:bagi_chat/core/errors/failure.dart';
import 'package:bagi_chat/features/people/data/models/person_model.dart';
import 'package:bagi_chat/features/people/domain/entities/person.dart';
import '../../../../core/errors/exeptions.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/person_repository.dart';
import '../../domain/use_cases/people_use_cases.dart';
import '../data_sources/person_remote_data_source.dart';

class PersonRepositoryImpl extends PersonRepository {
  final PersonRemoteDataSource remoteDataSource;

  PersonRepositoryImpl({required this.remoteDataSource});

  @override
  Either<Failure, Stream<List<Person>>> getConcretePeople(
      {String? searchParams}) {
    try {
      var res = remoteDataSource.getConcretePeople(searchParams: searchParams);
      return Right(res);
    } on ServerException {
      return const Left(ServerFailure("server"));
    }
  }

  @override
  Either<Failure, Stream<Person>> getConcretePerson(String uid) {
    try {
      var res = remoteDataSource.getConcretePerson(uid);
      return Right(res);
    } on ServerException {
      return const Left(ServerFailure("server"));
    }
  }

  @override
  Future<Either<Failure, bool>> postConcreteEditProfile(
      EditProfParams params) async {
    try {
      var res = await remoteDataSource.postConcreteEditProfile(params);
      return Right(res);
    } on ServerException {
      return const Left(ServerFailure("server"));
    }
  }

  @override
  Future<Either<Failure, String>> postConcreteUpdatePicture(Uint8List bytes) async{
    try {
      var res = await remoteDataSource.postConcreteUpdatePicture(bytes);
      return Right(res);
    } on ServerException {
      return const Left(ServerFailure("server"));
    }
  }
}
