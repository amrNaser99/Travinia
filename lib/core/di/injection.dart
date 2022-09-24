import 'package:get_it/get_it.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/presentation/auth/bloc/auth_cubit.dart';
import 'package:travinia/presentation/explore/bloc/explore_cubit.dart';
import 'package:travinia/services/api_service/dio_helper.dart';
import 'package:travinia/services/repositories/repository.dart';

import '../../presentation/hotel_details/hotel_details_cubit/hotel_details_cubit.dart';
import '../../services/api_service/dio_impl.dart';
import '../../services/repositories/repository_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => HotelDetailsCubit());

  sl.registerFactory(() => AppCubit(
        repository: sl(),
      ));
  sl.registerFactory(() => AuthCubit(
        repository: sl(),
      ));

  sl.registerFactory(() => ExploreHotelCubit(
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
