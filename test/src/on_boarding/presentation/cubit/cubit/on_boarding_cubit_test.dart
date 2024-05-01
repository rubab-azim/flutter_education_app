import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_education_app/core/error/failure.dart';
import 'package:flutter_education_app/src/on_boarding/domain/usecases/cache_first_timer_usecase.dart';
import 'package:flutter_education_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:flutter_education_app/src/on_boarding/presentation/cubit/cubit/on_boarding_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCacheFirstTimerUsecase extends Mock
    implements CacheFirstTimerUsecase {}

class MockCheckIfUserIsFirstTimerUseCase extends Mock
    implements CheckIfUserIsFirstTimerUseCase {}

void main() {
  late MockCacheFirstTimerUsecase cacheFirstTimerUsecase;
  late MockCheckIfUserIsFirstTimerUseCase checkIfUserIsFirstTimerUseCase;
  late OnBoardingCubit cubit;

  setUp(() {
    cacheFirstTimerUsecase = MockCacheFirstTimerUsecase();
    checkIfUserIsFirstTimerUseCase = MockCheckIfUserIsFirstTimerUseCase();
    cubit = OnBoardingCubit(
        cacheFirstTimerUsecase: cacheFirstTimerUsecase,
        checkIfUserIsFirstTimerUseCase: checkIfUserIsFirstTimerUseCase);
  });

  test('[onBoarding.Inital] should be our intials state', () {
    expect(cubit.state, const OnBoardingInitial());
  });
  final tFailure = CacheFailure(
    message: 'Insufficient storage permission',
    statusCode: 4032,
  );
  group('chacheFirstTimer', () {
    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CachingFirstTimer, UserCached] '
      'when call to [onboarding.cacheFirstTimer] is successful',
      build: () {
        when(
          () => cacheFirstTimerUsecase(),
        ).thenAnswer((_) async => const Right(null));
        return cubit;
      },
      act: (cubit) => cubit.cacheFirstTimer(),
      expect: () => const [CachingFirstTimer(), UserCached()],
      verify: (bloc) {
        verify(
          () => cacheFirstTimerUsecase(),
        ).called(1);

        verifyNoMoreInteractions(cacheFirstTimerUsecase);
      },
    );

    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CachingFirstTimer, OnBoardingError] '
      'when call to [onboarding.cacheFirstTimer] is unSuccessful',
      build: () {
        when(
          () => cacheFirstTimerUsecase(),
        ).thenAnswer((_) async => Left(tFailure));
        return cubit;
      },
      act: (cubit) => cubit.cacheFirstTimer(),
      expect: () => [
        const CachingFirstTimer(),
        OnBoardingError(message: tFailure.errorMessage),
      ],
      verify: (bloc) {
        verify(
          () => cacheFirstTimerUsecase(),
        ).called(1);

        verifyNoMoreInteractions(cacheFirstTimerUsecase);
      },
    );
  });

  group('checkIfUserIsFirstTimer', () {
    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CheckIfUserIsFirstTimer, OnBoardingStatus] '
      'when call to [onboarding.checkIfUserIsFirstTimer] is successful',
      build: () {
        when(
          () => checkIfUserIsFirstTimerUseCase(),
        ).thenAnswer((_) async => const Right(true));
        return cubit;
      },
      act: (cubit) => cubit.checkIfUserIsFirstTimer(),
      expect: () => const [
        CheckIfUserIsFirstTimer(),
        OnBoardingStatus(isFirstTimer: true),
      ],
      verify: (bloc) {
        verify(
          () => checkIfUserIsFirstTimerUseCase(),
        ).called(1);

        verifyNoMoreInteractions(checkIfUserIsFirstTimerUseCase);
      },
    );

    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CheckIfUserIsFirstTimer, OnBoardingStatus(true)] '
      'when call to [onboarding.checkIfUserIsFirstTimer] is unSuccessful',
      build: () {
        when(
          () => checkIfUserIsFirstTimerUseCase(),
        ).thenAnswer((_) async => Left(tFailure));
        return cubit;
      },
      act: (cubit) => cubit.checkIfUserIsFirstTimer(),
      expect: () => const [
        CheckIfUserIsFirstTimer(),
        OnBoardingStatus(isFirstTimer: true),
      ],
      verify: (bloc) {
        verify(
          () => checkIfUserIsFirstTimerUseCase(),
        ).called(1);

        verifyNoMoreInteractions(checkIfUserIsFirstTimerUseCase);
      },
    );
  });
}
