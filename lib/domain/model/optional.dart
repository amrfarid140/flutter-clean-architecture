import 'package:sealed_unions/sealed_unions.dart';

class Optional<T> extends Union2Impl<Available,NotAvailable> {
  static Doublet<Available,NotAvailable> _doublet =
      Doublet<Available,NotAvailable>();
  
  Optional._(Union2<Available<T>, NotAvailable> union) : super(union);

  factory Optional.available(T data) => Optional._(_doublet.first(Available._(data)));
  factory Optional.notAvailable() => Optional._(_doublet.second(NotAvailable._()));
}

class Available<T> {
  T data;
  Available._(this.data);
}

class NotAvailable {
  NotAvailable._();
}