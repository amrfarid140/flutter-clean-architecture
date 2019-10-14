import 'package:clean_weather/data/mapper/api_current_weather_mapper.dart';
import 'package:clean_weather/data/model/api_current_weather.dart';
import 'package:clean_weather/data/model/api_weather_forecast.dart';
import 'package:clean_weather/data/remote_server_error.dart';
import 'package:clean_weather/data/remote_weather_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class _MockDio extends Mock implements Dio {}

class _MockApiCurrentWeatherMapper extends Mock
    implements ApiCurrentWeatherMapper {}

void main() {
  final mockDio = _MockDio();
  final mockMapper = _MockApiCurrentWeatherMapper();

  group("RemoteWeatherRepository test", () {
    test(
        "given get request status code is not 200 when getCurrentWeather then RemoteServerError",
        (){
      // Given
      when(mockDio.get<ApiCurrentWeather>(any,
              queryParameters: anyNamed("queryParameters")))
          .thenAnswer((_) {
        return Future.value(Response(statusCode: 404));
      });
      // When
      expect(
          () async => await RemoteWeatherRepository(mockDio, mockMapper)
              .getCurrentWeather(),
          throwsA((e) => e is RemoteServerError));
    });

    test("given get request status code is 200 when getCurrentWeather then data is mapped", () async {
      // Given
      when(mockDio.get<ApiCurrentWeather>(any,
          queryParameters: anyNamed("queryParameters")))
          .thenAnswer((_) {
        return Future.value(Response(statusCode: 200, data: null));
      });
      // When
      await RemoteWeatherRepository(mockDio, mockMapper).getCurrentWeather();
      // Then
      verify(mockMapper.map(any));
    });

    test(
        "given get request status code is not 200 when getWeatherForecast then RemoteServerError",
            (){
          // Given
          when(mockDio.get<ApiWeatherForecast>(any,
              queryParameters: anyNamed("queryParameters")))
              .thenAnswer((_) {
            return Future.value(Response(statusCode: 404));
          });
          // When
          expect(
                  () async => await RemoteWeatherRepository(mockDio, mockMapper)
                  .getWeatherForecast(),
              throwsA((e) => e is RemoteServerError));
        });

    test(
        "given get request status code is 200 when getWeatherForecast then data is mapped",
            () async {
          // Given
          when(mockDio.get<ApiWeatherForecast>(any,
              queryParameters: anyNamed("queryParameters")))
              .thenAnswer((_) {
            return Future.value(Response(statusCode: 200, data: ApiWeatherForecast([null])));
          });
          // When
          await RemoteWeatherRepository(mockDio, mockMapper).getWeatherForecast();
          // Then
          verify(mockMapper.map(any));
        });
  });
}
