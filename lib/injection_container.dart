import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'features/auth/data/data_sources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/use_cases/get_concreate_auth.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Use cases
  sl.registerLazySingleton(() => GetConcreteSendCode(sl()));
  sl.registerLazySingleton(() => PostConcreteLogin(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<LoginRemoteDataSource>(
          () => LoginRemoteDataSourceImpl(client: sl()));

  // Data sources
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);


  //! External
  // final sharedPreferences = await SharedPreferences.getInstance();
  // sl.registerLazySingleton(() => sharedPreferences);
  // sl.registerLazySingleton(() => http.Client());
  // sl.registerLazySingleton(() => DataConnectionChecker());
}