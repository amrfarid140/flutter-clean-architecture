import 'dart:async';

import 'package:clean_weather/bloc/action.dart';
import 'package:clean_weather/bloc/bloc.dart';
import 'package:clean_weather/bloc/state.dart';
import 'package:clean_weather/domain/usecase/get_weather_forecast_usecase.dart';
import 'package:clean_weather/domain/usecase/usecase_result.dart';
import 'package:rxdart/rxdart.dart';

class MyHomepageBloc extends Bloc {
  final BehaviorSubject<State> _state = BehaviorSubject();

  Observable<State> get state => _state;
  final PublishSubject<Action> _action = PublishSubject();

  StreamSink<Action> get action => _action.sink;

  final GetWeatherForecastUseCase _useCase;

  MyHomepageBloc(this._useCase) {
    _loadData();
    _action.listen((action) => action.join((refresh) => _loadData(), () {}));
  }

  void _loadData() async {
    _state.add(State.loading());
    final UseCaseResult<WeatherForecast> result = await _useCase.execute();
   _state.add(result.join((success) => State.ready(), (error) => State.error()));
  }

  @override
  void dispose() {
    _state.close();
    _action.close();
  }
}
