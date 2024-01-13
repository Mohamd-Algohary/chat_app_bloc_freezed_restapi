import 'package:dartz/dartz.dart';

import '/domain/model/model.dart';

abstract class BaseUsecase<In, Out> {
  Future<Either<Failure, Out>> excute(In input);
}
