import 'dart:core';

import 'package:clean_weather/bloc/my_homepage_bloc.dart';
import 'package:clean_weather/bloc/state.dart';
import 'package:clean_weather/domain/usecase/get_weather_forecast_usecase.dart';
import 'package:clean_weather/domain/usecase/usecase_result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class _MockUseCase extends Mock implements GetWeatherForecastUseCase {}

class _MockWeatherForecast extends Mock implements WeatherForecast {}

void main() {
  group("MyHomepageBloc test", () {
    final mockUseCase = _MockUseCase();
    test("given usecase sucess then result is ready", () async {
      when(mockUseCase.execute()).thenAnswer(
          (_) => Future.value(UseCaseResult.success(_MockWeatherForecast())));
      final result = MyHomepageBloc(mockUseCase);
      await untilCalled(mockUseCase.execute());
      expect(result.state, emits((State state) {
        return state.join((ready) => true, (loading) => false, (error) => false);
      }));
    });

    test("given usecase failure then result is error", () async {
      when(mockUseCase.execute()).thenAnswer(
              (_) => Future.value(UseCaseResult.error(ArgumentError())));
      final result = MyHomepageBloc(mockUseCase);
      await untilCalled(mockUseCase.execute());
      expect(result.state, emits((State state) {
        return state.join((ready) => false, (loading) => false, (error) => true);
      }));
    });

    test("given usecase executing then result is loading", () async {
      when(mockUseCase.execute()).thenAnswer(
              (_) => Future.value(UseCaseResult.error(ArgumentError())));
      final result = MyHomepageBloc(mockUseCase);
      expect(result.state, emits((State state) {
        return state.join((ready) => false, (loading) => true, (error) => false);
      }));

      tearDown((){
        reset(mockUseCase);
      });
    });
  });
}
