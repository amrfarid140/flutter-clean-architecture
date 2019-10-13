import 'package:clean_weather/domain/model/weather_data_item.dart';

abstract class WeatherRepository {
  Future<WeatherDataItem> getCurrentWeather();
  Future<List<WeatherDataItem>> getWeatherForecast();
}