import 'package:sealed_unions/sealed_unions.dart';

class Optional<T> extends Union2Impl<Available<T>,NotAvailable> {
  static Doublet<Available<T>,NotAvailable> _doublet<T>() =>
      Doublet<Available<T>,NotAvailable>();
  
  Optional._(Union2<Available<T>, NotAvailable> union) : super(union);

  factory Optional.available(T data) => Optional._(_doublet<T>().first(Available._(data)));
  factory Optional.notAvailable() => Optional._(_doublet<T>().second(NotAvailable._()));
}

class Available<T> {
  T data;
  Available._(this.data);
}

class NotAvailable {
  NotAvailable._();
}