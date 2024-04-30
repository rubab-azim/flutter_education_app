import 'package:dartz/dartz.dart';
import 'package:flutter_education_app/core/error/failure.dart';
import 'package:flutter_education_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../onboarding_repo.mock.dart';

void main() {
  late MockOnboardingRepo repo;
  late CheckIfUserIsFirstTimer usecase;

  setUpAll(() {
    repo = MockOnboardingRepo();
    usecase = CheckIfUserIsFirstTimer(repo);
  });

  final Failure failure = ServerFailure(
    message: 'unknown error occured',
    statusCode: 500,
  );

  test(
      'should call the [onBardingRepo.checkIfUserIsFirstTimer] '
      'and return the right value', () async {
    when(() => repo.checkIfUserIsFirstTimer()).thenAnswer(
      (_) async => Left(failure),
    );

    final result = await usecase();

    expect(result, equals(Left<Failure, dynamic>(failure)));
    verify(() => repo.checkIfUserIsFirstTimer()).called(1);
    verifyNoMoreInteractions(repo);
  });

  test('shlould get a response from  the [MockOnboardingRepo]', () async {
    when(
      () => repo.checkIfUserIsFirstTimer(),
    ).thenAnswer((_) async => const Right(true));

    final result = await usecase();

    expect(result, equals(const Right<dynamic, bool>(true)));
    verify(() => repo.checkIfUserIsFirstTimer()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
