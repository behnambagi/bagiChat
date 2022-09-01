import 'dart:typed_data';
import 'package:bagi_chat/features/people/domain/entities/person.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../use_cases/people_use_cases.dart';

abstract class PersonRepository {
  Either<Failure, Stream<List<Person>>> getConcretePeople({String? searchParams});
  Either<Failure, Stream<Person>> getConcretePerson(String uid);
  Future<Either<Failure, bool>> postConcreteEditProfile(EditProfParams params);
  Future<Either<Failure, String>> postConcreteUpdatePicture(Uint8List bytes);
}

