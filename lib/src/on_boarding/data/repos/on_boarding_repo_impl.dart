import 'package:dartz/dartz.dart';
import 'package:flutter_education_app/core/error/exception.dart';
import 'package:flutter_education_app/core/error/failure.dart';
import 'package:flutter_education_app/core/utils/typdefs.dart';
import 'package:flutter_education_app/src/on_boarding/data/datasource/on_boarding_local_datasrc.dart';
import 'package:flutter_education_app/src/on_boarding/domain/repo/on_boarding_repo.dart';

class OnboardingRepoImp implements OnBoardingRepository {
  OnboardingRepoImp(this._localDataSrc);

  final OnBoardingLocalDataSrc _localDataSrc;

  @override
  ResultFuture<void> cacheFirstTimer() async {
    try {
      await _localDataSrc.cacheFirstTimer();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<bool> checkIfUserIsFirstTimer() async {
    try {
      final result = await _localDataSrc.checkIfUserIsFirstTimer();
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
