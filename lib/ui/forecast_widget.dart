import 'package:clean_weather/domain/model/weather_data_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ForecastWidget extends StatelessWidget {
  final List<WeatherDataItem> _data;
  final dateFormatter = new DateFormat('yyyy-MM-dd');
  ForecastWidget(this._data);

  @override
  Widget build(BuildContext context) {
    if (_data.isEmpty) {
      return Container();
    } else {
      return ListView(
        shrinkWrap: true,
        children: <Widget>[
          ..._data.map((item) {
            final time = DateTime.fromMillisecondsSinceEpoch(item.time);
            return Container(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("Date:"),
                      Text(dateFormatter.format(time))
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
          })
        ],
      );
    }
  }
}
