import 'optional.dart';

class WeatherDataItem {
  final int time;
  final double high;
  final double min;
  final Optional<double> current;
  WeatherDataItem(this.time, this.high, this.min, this.current);
}
