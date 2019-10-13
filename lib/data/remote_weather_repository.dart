import 'dart:io';

import 'package:clean_weather/data/mapper/api_current_weather_mapper.dart';
import 'package:clean_weather/data/model/api_weather_forecast.dart';
import 'package:clean_weather/domain/model/weather_data_item.dart';
import 'package:clean_weather/domain/weather_repository.dart';
import 'package:dio/dio.dart';

import 'model/api_current_weather.dart';

class RemoteWeatherRepository extends WeatherRepository {
  final Dio _dio;
  final ApiCurrentWeatherMapper _currentWeatherMapper;

  RemoteWeatherRepository(this._dio, this._currentWeatherMapper);

  @override
  Future<WeatherDataItem> getCurrentWeather() async {
    final Response<ApiCurrentWeather> apiResponse = await _dio
        .get<ApiCurrentWeather>("/data/2.5/weather",
            queryParameters: {"q": "London,UK"});
    if (apiResponse.statusCode != 200) {
      throw HttpException("API Failed to get current weather");
    }
    return _currentWeatherMapper.map(apiResponse.data);
  }

  @override
  Future<List<WeatherDataItem>> getWeatherForecast() async {
    final Response<ApiWeatherForecast> apiResponse = await _dio
        .get<ApiWeatherForecast>("/data/2.5/forecast",
            queryParameters: {"q": "London,UK"});
    if (apiResponse.statusCode != 200) {
      throw HttpException("API Failed to get current weather");
    }
    return apiResponse.data.list
        .map((model) => _currentWeatherMapper.map(model))
        .toList();
  }
}
