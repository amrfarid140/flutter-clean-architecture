import 'package:sealed_unions/sealed_unions.dart';

class UseCaseResult<T> extends Union2Impl<Success, Failure> {
  static final Doublet<Success, Failure> _doublet =
      Doublet();

  UseCaseResult._(Union2<Success, Failure> union) : super(union);

  factory UseCaseResult.success(T data) =>
      UseCaseResult._(_doublet.first(Success._(data)));

  factory UseCaseResult.error(dynamic error) =>
      UseCaseResult._(_doublet.second(Failure._(error)));
}

class Success<T> {
  T data;

  Success._(this.data);
}

class Failure {
  dynamic error;

  Failure._(this.error);
}
