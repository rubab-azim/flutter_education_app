import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_education_app/src/on_boarding/domain/usecases/cache_first_timer_usecase.dart';
import 'package:flutter_education_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit({
    required CacheFirstTimerUsecase cacheFirstTimerUsecase,
    required CheckIfUserIsFirstTimerUseCase checkIfUserIsFirstTimerUseCase,
  })  : _cacheFirstTimerUsecase = cacheFirstTimerUsecase,
        _checkIfUserIsFirstTimerUseCase = checkIfUserIsFirstTimerUseCase,
        super(const OnBoardingInitial());

  final CacheFirstTimerUsecase _cacheFirstTimerUsecase;
  final CheckIfUserIsFirstTimerUseCase _checkIfUserIsFirstTimerUseCase;

  Future<void> cacheFirstTimer() async {
    emit(const CachingFirstTimer());

    final result = await _cacheFirstTimerUsecase();

    result.fold(
      (failure) => emit(OnBoardingError(message: failure.errorMessage)),
      (_) => emit(const UserCached()),
    );
  }

  Future<void> checkIfUserIsFirstTimer() async {
    emit(const CheckIfUserIsFirstTimer());
    final result = await _checkIfUserIsFirstTimerUseCase();

    result.fold(
      (failure) => emit(
        const OnBoardingStatus(isFirstTimer: true),
      ),
      (isFirstTimer) => emit(OnBoardingStatus(isFirstTimer: isFirstTimer)),
    );
  }
}
