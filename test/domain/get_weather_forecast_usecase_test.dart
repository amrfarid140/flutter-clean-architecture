import 'package:clean_weather/domain/model/weather_data_item.dart';
import 'package:clean_weather/domain/usecase/get_weather_forecast_usecase.dart';
import 'package:clean_weather/domain/weather_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class _MockWeatherRepository extends Mock implements WeatherRepository {}

class _MockWeatherDataItem extends Mock implements WeatherDataItem {}

void main() {
  group("GetWeatherForecastUseCase test", () {
    final mockWeatherRepository = _MockWeatherRepository();
    test(
        "given weather repository errors when fetching today weather then result is usecase error",
        () async {
      // Given
      when(mockWeatherRepository.getCurrentWeather())
          .thenThrow(ArgumentError());
      when(mockWeatherRepository.getWeatherForecast())
          .thenAnswer((_) => Future.value([]));
      // When
      final result =
          await GetWeatherForecastUseCase(mockWeatherRepository).execute();
      // Then
      expect(result.join((success) => false, (error) => true), equals(true));
    });

    test(
        "given weather repository errors when fetching forecast then result is usecase error",
        () async {
      // Given
      when(mockWeatherRepository.getCurrentWeather())
          .thenAnswer((_) => Future.value(_MockWeatherDataItem()));
      when(mockWeatherRepository.getWeatherForecast())
          .thenThrow(ArgumentError());
      // When
      final result =
          await GetWeatherForecastUseCase(mockWeatherRepository).execute();
      // Then
      expect(result.join((success) => false, (error) => true), equals(true));
    });

    test(
        "given weather repository success when fetching forecast and current weather then result is usecase success",
        () async {
      // Given
      when(mockWeatherRepository.getCurrentWeather())
          .thenAnswer((_) => Future.value(_MockWeatherDataItem()));
      when(mockWeatherRepository.getWeatherForecast())
          .thenAnswer((_) => Future.value([]));
      // When
      final result =
          await GetWeatherForecastUseCase(mockWeatherRepository).execute();
      // Then
      expect(
          result.join((success) => true && success.data is WeatherForecast,
              (error) => false),
          equals(true));
    });

    tearDown((){
      reset(mockWeatherRepository);
    });
  });
}
