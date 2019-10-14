import 'dart:convert';

import 'package:clean_weather/data/model/api_current_weather.dart';
import 'package:clean_weather/data/model/api_weather_forecast.dart';
import 'package:clean_weather/ui/app.dart';
import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

_parseAndDecode(String response) {
  Map<String, dynamic> data = jsonDecode(response);
  if (data.containsKey("list")) {
    final List itemData = data["list"];
    final List<ApiCurrentWeather> datass =
        itemData.map<ApiCurrentWeather>((item) {
      final mainData = item["main"];

      return ApiCurrentWeather(
          dt: item["dt"] * 1000,
          main: ApiCurrentWeatherMain(
            temp_max: mainData["temp_max"].toDouble(),
            temp_min: mainData["temp_min"].toDouble(),
            temp: mainData["temp"].toDouble(),
            humidity: mainData["humidity"].toDouble(),
            pressure: mainData["pressure"].toDouble(),
          ));
    }).toList();
    return ApiWeatherForecast(datass);
  } else {
    final mainData = data["main"];

    return ApiCurrentWeather(
        dt: data["dt"],
        main: ApiCurrentWeatherMain(
          temp_max: mainData["temp_max"].toDouble(),
          temp_min: mainData["temp_min"].toDouble(),
          temp: mainData["temp"].toDouble(),
          humidity: mainData["humidity"].toDouble(),
          pressure: mainData["pressure"].toDouble(),
        ));
  }
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

void main() {
  final dio = Dio(BaseOptions(
      baseUrl: "https://api.openweathermap.org/",
      queryParameters: {
        "appid": "cda04748731c6db0081244514eb5b628",
        "units": "metric"
      }));
  dio.transformer = FlutterTransformer();
  (dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
  runApp(MyApp(dio));
}
