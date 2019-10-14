/**
 * Inspired by Didier Boelens
 *
 * https://www.didierboelens.com/2018/12/reactive-programming---streams---bloc---practical-use-cases/
 */

import 'package:clean_weather/bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:sealed_unions/sealed_unions.dart';

typedef T Builder<T>(BuildContext context);

Type _typeOf<T>() => T;

class DependencyProvider extends StatefulWidget {
  final Widget child;
  final List<Dependency> definitions;
  final Map<Type, Object> singeltons = Map();

  DependencyProvider({Key key, @required this.child, @required this.definitions})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DependencyProviderState();
  }

  static T get<T>(BuildContext context) {
    _DependencyProviderInherited provider = context
        .ancestorInheritedElementForWidgetOfExactType(
        _DependencyProviderInherited)
        .widget;

    return _getInstance<T>(provider, context);
  }

  static T _getInstance<T>(_DependencyProviderInherited provider, BuildContext context) {
    Dependency dependency =
    provider.definitions.firstWhere((dep) => dep._type == _typeOf<T>());

    return dependency.join((singelton) {
      if (provider.singeltons.containsKey(dependency._type)) {
        return provider.singeltons[dependency._type];
      } else {
        final T instance = dependency._builder(context);
        provider.singeltons[dependency._type] = instance;
        return instance;
      }
    }, (instance) {
      return dependency._builder(context);
    });
  }
}

class _DependencyProviderState extends State<DependencyProvider> {
  @override
  void dispose() {
    widget.singeltons.values.forEach((object) {
      if (object is Bloc) object.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new _DependencyProviderInherited(
      singeltons: widget.singeltons,
      definitions: widget.definitions,
      child: widget.child,
    );
  }
}

class Dependency<T> extends Union2Impl<Singelton, Instance> {
  Builder<T> _builder;
  Type _type;

  static Doublet<Singelton, Instance> _factory = new Doublet();

  Dependency(Union2<Singelton, Instance> union, this._builder, this._type)
      : super(union);

  factory Dependency.singelton(Builder<T> builder, Type type) =>
      Dependency(_factory.first(Singelton._()), builder, type);

  factory Dependency.instance(Builder<T> builder, Type type) =>
      Dependency(_factory.second(Instance._()), builder, type);
}

class Singelton {
  Singelton._();
}

class Instance {
  Instance._();
}

class _DependencyProviderInherited extends InheritedWidget {
  final List<Dependency> definitions;
  final Map<Type, Object> singeltons;

  _DependencyProviderInherited({Key key, @required Widget child, this.definitions, this.singeltons})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
