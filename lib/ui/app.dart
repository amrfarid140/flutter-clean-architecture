import 'package:clean_weather/bloc/dependency_provider.dart';
import 'package:clean_weather/bloc/my_homepage_bloc.dart';
import 'package:clean_weather/data/mapper/api_current_weather_mapper.dart';
import 'package:clean_weather/data/remote_weather_repository.dart';
import 'package:clean_weather/domain/usecase/get_weather_forecast_usecase.dart';
import 'package:clean_weather/domain/weather_repository.dart';
import 'package:clean_weather/ui/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MyApp extends StatelessWidget {
  final Dio _dio;

  MyApp(this._dio);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DependencyProvider(
        definitions: [
          Dependency.singelton(
                  (_) => ApiCurrentWeatherMapper(), ApiCurrentWeatherMapper),
          Dependency.singelton(
                  (providerContext) => RemoteWeatherRepository(
                  this._dio, DependencyProvider.get(providerContext)),
              WeatherRepository),
          Dependency.singelton(
                  (providerContext) => GetWeatherForecastUseCase(
                  DependencyProvider.get(providerContext)),
              GetWeatherForecastUseCase),
          Dependency.instance(
                  (providerContext) =>
                  MyHomepageBloc(DependencyProvider.get(providerContext)),
              MyHomepageBloc)
        ],
        child: MyHomePage(),
      ),
    );
  }
}
