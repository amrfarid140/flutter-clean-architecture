import 'package:clean_weather/domain/model/weather_data_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ForecastWidget extends StatelessWidget {
  final List<WeatherDataItem> _data;
  final dateFormatter = new DateFormat('yyyy-MM-dd');
  final timeFormatter = new DateFormat('HH:mm');

  ForecastWidget(this._data);

  @override
  Widget build(BuildContext context) {
    if (_data.isEmpty) {
      return Container();
    } else {
      return Scrollbar(
          child: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (BuildContext context, int index) {
          final item = _data[index];
          final time =
              DateTime.fromMillisecondsSinceEpoch(item.time, isUtc: true);
          return Container(
            height: 80,
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Date:"),
                    Text(dateFormatter.format(time)),
                    Text(" At:"),
                    Text(timeFormatter.format(time))
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("High: ${item.high} / Low: ${item.min}")
                  ],
                )
              ],
            ),
          );
        },
      ));
    }
  }
}
