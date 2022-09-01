import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'features/auth/data/auth_data.dart';
import 'features/auth/domain/auth_domain.dart';
import 'features/people/domain/people_domain.dart';
import 'features/people/data/people_data.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Use cases
  sl.registerLazySingleton(() => GetConcreteSendCode(sl()));
  sl.registerLazySingleton(() => PostConcreteLogin(sl()));
  sl.registerLazySingleton(() => GetConcretePerson(sl()));
  sl.registerLazySingleton(() => GetConcretePeople(sl()));
  sl.registerLazySingleton(() => PostConcreteEditProfile(sl()));
  sl.registerLazySingleton(() => PostConcreteUpdatePicture(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
          () => AuthRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<PersonRepository>(
          () => PersonRepositoryImpl(remoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<LoginRemoteDataSource>(
          () => LoginRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PersonRemoteDataSource>(
          () => PersonRemoteDataSourceImpl(client: sl(), auth: sl(),storage: sl()));

  // Data sources
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);


  //! External
  // final sharedPreferences = await SharedPreferences.getInstance();
  // sl.registerLazySingleton(() => sharedPreferences);
  // sl.registerLazySingleton(() => http.Client());
  // sl.registerLazySingleton(() => DataConnectionChecker());
}