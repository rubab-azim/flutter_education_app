import 'package:flutter_education_app/core/utils/typdefs.dart';

abstract class OnBoardingRepository {
  const OnBoardingRepository();
  ResultFuture<void> cacheFirstTimer();
  ResultFuture<bool> checkIfUserIsFirstTimer();
}
