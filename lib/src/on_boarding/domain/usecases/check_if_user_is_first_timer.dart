import 'package:flutter_education_app/core/usecases/usecases.dart';
import 'package:flutter_education_app/core/utils/typdefs.dart';
import 'package:flutter_education_app/src/on_boarding/domain/repo/on_boarding_repo.dart';

class CheckIfUserIsFirstTimer extends UsecaseWithoutParams<bool> {
  const CheckIfUserIsFirstTimer(this._repo);

  final OnBoardingRepository _repo;
  @override
  ResultFuture<bool> call() => _repo.checkIfUserIsFirstTimer();
}
