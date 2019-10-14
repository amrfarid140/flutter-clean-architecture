import 'package:clean_weather/domain/model/weather_data_item.dart';
import 'package:sealed_unions/sealed_unions.dart';

class State extends Union3Impl<Ready, Loading, Error> {
  static Triplet<Ready, Loading, Error> _factory = Triplet();

  State(Union3<Ready, Loading, Error> union) : super(union);

  factory State.ready(
          WeatherDataItem todayWeather, List<WeatherDataItem> forecast) =>
      State(_factory.first(Ready._(todayWeather, forecast)));

  factory State.loading() => State(_factory.second(Loading._()));

  factory State.error() => State(_factory.third(Error._()));
}

class Ready {
  final WeatherDataItem todayWeather;
  final List<WeatherDataItem> forecast;

  Ready._(this.todayWeather, this.forecast);
}

class Loading {
  Loading._();
}

class Error {
  Error._();
}
