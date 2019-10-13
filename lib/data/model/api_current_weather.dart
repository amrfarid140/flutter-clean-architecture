class ApiCurrentWeather {
  final int dt;
  final ApiCurrentWeatherMain main;

  ApiCurrentWeather({this.dt, this.main});
}

class ApiCurrentWeatherMain {
  final double temp;
  final double pressure;
  final double humidity;
  final double temp_min;
  final double temp_max;

  ApiCurrentWeatherMain(
      {this.humidity, this.pressure, this.temp, this.temp_max, this.temp_min});
}
