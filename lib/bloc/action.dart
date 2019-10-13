import 'package:sealed_unions/sealed_unions.dart';

class Action extends Union1Impl<Refresh> {
  static Singlet<Refresh> _factory = Singlet();

  Action(Union1 union) : super(union);

  factory Action.refresh() =>
      Action(_factory.first(Refresh._()));
}

class Refresh {
  Refresh._();
}
