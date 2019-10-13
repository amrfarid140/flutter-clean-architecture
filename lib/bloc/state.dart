import 'package:sealed_unions/sealed_unions.dart';

class State extends Union3Impl<Ready, Loading, Error> {
  static Triplet<Ready, Loading, Error> _factory = Triplet();

  State(Union3<Ready, Loading, Error> union) : super(union);

  factory State.ready() => _factory.first(Ready._());

  factory State.loading() => _factory.second(Loading._());

  factory State.error() => _factory.third(Error._());
}

class Ready {
  Ready._();
}

class Loading {
  Loading._();
}

class Error {
  Error._();
}
