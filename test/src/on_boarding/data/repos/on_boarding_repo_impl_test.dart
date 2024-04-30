import 'package:dartz/dartz.dart';
import 'package:flutter_education_app/core/error/exception.dart';
import 'package:flutter_education_app/core/error/failure.dart';
import 'package:flutter_education_app/src/on_boarding/data/datasource/on_boarding_local_datasrc.dart';
import 'package:flutter_education_app/src/on_boarding/data/repos/on_boarding_repo_impl.dart';
import 'package:flutter_education_app/src/on_boarding/domain/repo/on_boarding_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnBoardingLocalDataSrc extends Mock
    implements OnBoardingLocalDataSrc {}

void main() {
  late MockOnBoardingLocalDataSrc localDataSrc;
  late OnboardingRepoImp onboardingRepoImp;

  setUpAll(() {
    localDataSrc = MockOnBoardingLocalDataSrc();
    onboardingRepoImp = OnboardingRepoImp(localDataSrc);
  });

  test('should implement onBoardingRepository', () {
    expect(onboardingRepoImp, isA<OnBoardingRepository>());
  });

  group('cacheFirstTimer', () {
    test(
        'should complete successfully when call to local '
        'datasource is successful', () async {
      when(() => localDataSrc.cacheFirstTimer())
          .thenAnswer((_) async => Future.value());

      final result = await onboardingRepoImp.cacheFirstTimer();

      expect(result, equals(const Right<dynamic, void>(null)));

      verify(
        () => localDataSrc.cacheFirstTimer(),
      ).called(1);

      verifyNoMoreInteractions(localDataSrc);
    });

    test(
        'should return [cacheFailure] when call '
        'to localdatasrc is unsucessfull', () async {
      when(
        () => localDataSrc.cacheFirstTimer(),
      ).thenThrow(const CacheException(message: 'Insufficent storage'));

      final result = await onboardingRepoImp.cacheFirstTimer();

      expect(
        result,
        equals(
          Left<CacheFailure, dynamic>(
            CacheFailure(message: 'Insufficent storage', statusCode: 500),
          ),
        ),
      );
      verify(
        () => localDataSrc.cacheFirstTimer(),
      ).called(1);

      verifyNoMoreInteractions(localDataSrc);
    });
  });

  group('checkIfUserIsFirstTimer', () {
    test(
        'should complete successfully when call to local '
        'datasource is successful', () async {
      when(() => localDataSrc.checkIfUserIsFirstTimer())
          .thenAnswer((_) async => false);

      final result = await onboardingRepoImp.checkIfUserIsFirstTimer();

      expect(result, equals(const Right<dynamic, bool>(false)));

      verify(
        () => localDataSrc.checkIfUserIsFirstTimer(),
      ).called(1);

      verifyNoMoreInteractions(localDataSrc);
    });

    test(
        'should return [cacheFailure] when call '
        'to localdatasrc is unsucessfull', () async {
      when(
        () => localDataSrc.checkIfUserIsFirstTimer(),
      ).thenThrow(
        const CacheException(
          message: 'Insufficent storage',
        ),
      );

      final result = await onboardingRepoImp.checkIfUserIsFirstTimer();

      expect(
        result,
        Left<CacheFailure, dynamic>(
          CacheFailure(message: 'Insufficent storage', statusCode: 500),
        ),
      );

      verify(
        () => localDataSrc.checkIfUserIsFirstTimer(),
      ).called(1);

      verifyNoMoreInteractions(localDataSrc);
    });
  });
}
