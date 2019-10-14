import 'package:clean_weather/domain/model/weather_data_item.dart';
import 'package:clean_weather/domain/usecase/usecase_result.dart';
import 'package:clean_weather/domain/weather_repository.dart';

class GetWeatherForecastUseCase {
  final WeatherRepository _weatherRepository;

  GetWeatherForecastUseCase(this._weatherRepository);

  Future<UseCaseResult<WeatherForecast>> execute() async {
    try {
      final todayWeather = await this._weatherRepository.getCurrentWeather();
      final fiveDayForecast =
          await this._weatherRepository.getWeatherForecast();
      return UseCaseResult<WeatherForecast>.success(
          WeatherForecast(todayWeather, fiveDayForecast));
    } catch (error) {
      print(error);
      return UseCaseResult<WeatherForecast>.error(error);
    }
  }
}

class WeatherForecast {
  final WeatherDataItem todayWeather;
  final List<WeatherDataItem> fiveDayForecast;

  WeatherForecast(this.todayWeather, this.fiveDayForecast);
}
