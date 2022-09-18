
import 'package:get_it/get_it.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/services/api_service/dio_helper.dart';
import 'package:travinia/services/repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => AppCubit(
    repository: sl(),
  ));

  sl.registerLazySingleton<DioHelper>(
        () => DioImpl(),
  );

  sl.registerLazySingleton<Repository>(
        () => RepositoryImplementation(
      dioHelper: sl(),
    ),
  );
}
