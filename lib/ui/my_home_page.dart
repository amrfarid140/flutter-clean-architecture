import 'package:clean_weather/domain/model/optional.dart';
import 'package:clean_weather/domain/model/weather_data_item.dart';
import 'package:clean_weather/ui/forecast_widget.dart';
import 'package:clean_weather/ui/today_widget.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather"),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TodayWidget(WeatherDataItem(DateTime.now().millisecondsSinceEpoch,
                22.2, 22.2, Optional.available(22.2))),
            ForecastWidget([WeatherDataItem(DateTime.now().millisecondsSinceEpoch,
                22.2, 22.2, Optional.available(22.2))])
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

