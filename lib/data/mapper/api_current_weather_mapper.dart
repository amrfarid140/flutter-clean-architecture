import 'package:clean_weather/data/model/api_current_weather.dart';
import 'package:clean_weather/domain/model/optional.dart';
import 'package:clean_weather/domain/model/weather_data_item.dart';

class ApiCurrentWeatherMapper {
  WeatherDataItem map(ApiCurrentWeather apiModel) {
    if (apiModel == null) {
      throw ArgumentError();
    }

    return WeatherDataItem(apiModel.dt, apiModel.main.temp_max,
        apiModel.main.temp_min, _getCurrentTemperature(apiModel.main));
  }

  Optional<double> _getCurrentTemperature(ApiCurrentWeatherMain apiModel) {
    if (apiModel.temp == null) {
      return Optional.notAvailable();
    } else {
      return Optional.available(apiModel.temp);
    }
  }
}
