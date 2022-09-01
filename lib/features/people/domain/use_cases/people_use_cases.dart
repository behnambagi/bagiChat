import 'dart:typed_data';

import 'package:bagi_chat/features/people/data/people_data.dart';
import 'package:bagi_chat/features/people/domain/entities/person.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/person_repository.dart';

class GetConcretePeople {
  final PersonRepository repository;

  GetConcretePeople(this.repository);

  Either<Failure, Stream<List<Person>>> call({String? params}) {
    return repository.getConcretePeople(searchParams: params);
  }
}

class PostConcreteEditProfile extends UseCase<bool, EditProfParams> {
  final PersonRepository repository;

  PostConcreteEditProfile(this.repository);

  @override
  Future<Either<Failure, bool>> call(EditProfParams params) async {
    return await repository.postConcreteEditProfile(params);
  }
}

class EditProfParams{
 final String name;
 final String? picUrl;
 EditProfParams({required this.name, this.picUrl});
}

class PostConcreteUpdatePicture extends UseCase<String, Uint8List> {
  final PersonRepository repository;

  PostConcreteUpdatePicture(this.repository);

  @override
  Future<Either<Failure, String>> call(Uint8List params) async {
    return await repository.postConcreteUpdatePicture(params);
  }
}

class GetConcretePerson {
  final PersonRepository repository;

  GetConcretePerson(this.repository);

  Either<Failure, Stream<Person>> call(String uid) {
    return repository.getConcretePerson(uid);
  }
}
