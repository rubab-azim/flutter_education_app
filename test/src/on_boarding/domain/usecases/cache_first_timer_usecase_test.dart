import 'package:dartz/dartz.dart';
import 'package:flutter_education_app/core/error/failure.dart';
import 'package:flutter_education_app/src/on_boarding/domain/usecases/cache_first_timer_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../onboarding_repo.mock.dart';

void main() {
  late MockOnboardingRepo repo;
  late CacheFirstTimerUsecase usecase;

  setUpAll(() {
    repo = MockOnboardingRepo();
    usecase = CacheFirstTimerUsecase(repo);
  });

  final Failure failure = ServerFailure(
    message: 'unknown error occured',
    statusCode: 500,
  );

  test(
      'should call the [onBardingRepo.cacheFirstTimer] '
      'and return the right value', () async {
    when(() => repo.cacheFirstTimer()).thenAnswer(
      (_) async => Left(failure),
    );

    final result = await usecase();

    expect(result, equals(Left<Failure, dynamic>(failure)));
    verify(() => repo.cacheFirstTimer()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
