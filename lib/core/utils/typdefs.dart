import 'package:dartz/dartz.dart';
import 'package:flutter_education_app/core/error/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef DataMap = Map<String, dynamic>;
