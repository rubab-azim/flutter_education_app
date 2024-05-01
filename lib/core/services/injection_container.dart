import 'package:flutter_education_app/src/on_boarding/data/datasource/on_boarding_local_datasrc.dart';
import 'package:flutter_education_app/src/on_boarding/data/repos/on_boarding_repo_impl.dart';
import 'package:flutter_education_app/src/on_boarding/domain/repo/on_boarding_repo.dart';
import 'package:flutter_education_app/src/on_boarding/domain/usecases/cache_first_timer_usecase.dart';
import 'package:flutter_education_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:flutter_education_app/src/on_boarding/presentation/cubit/cubit/on_boarding_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.asNewInstance();

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  //Feature onboarding

  sl
    ..registerFactory(
      () => OnBoardingCubit(
        cacheFirstTimerUsecase: sl(),
        checkIfUserIsFirstTimerUseCase: sl(),
      ),
    )
    ..registerLazySingleton(
      () => CacheFirstTimerUsecase(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => CheckIfUserIsFirstTimerUseCase(
        sl(),
      ),
    )
    ..registerLazySingleton<OnBoardingRepository>(
      () => OnboardingRepoImp(
        sl(),
      ),
    )
    ..registerLazySingleton<OnBoardingLocalDataSrc>(
      () => OnBoardingLocalDataSrcImpl(
        prefs,
      ),
    );
}
