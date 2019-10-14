import 'package:clean_weather/domain/model/weather_data_item.dart';
import 'package:flutter/material.dart';

class TodayWidget extends StatelessWidget {
  final WeatherDataItem _data;

  TodayWidget(this._data);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Today's Weather:",
            style: Theme.of(context).textTheme.title,
          ),
          Row(
            children: <Widget>[
              Text(
                "Current temprature:",
                style: Theme.of(context).textTheme.subtitle,
              ),
              Text(
                  _data.current.join(
                          (available) => available.data.toString(),
                          (notAvailable) => "Data not available"),
                  style: Theme.of(context).textTheme.subtitle)
            ],
          ),
          Text("High: ${_data.high}"),
          Text("Low: ${_data.high}"),
        ],
      ),
    );
  }
}