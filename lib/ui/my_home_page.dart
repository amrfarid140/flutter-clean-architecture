import 'package:clean_weather/bloc/action.dart' as homePage;
import 'package:clean_weather/bloc/my_homepage_bloc.dart';
import 'package:clean_weather/bloc/state.dart' as homePage;
import 'package:clean_weather/ui/error_widget.dart' as homePage;
import 'package:clean_weather/ui/forecast_widget.dart';
import 'package:clean_weather/ui/today_widget.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  final MyHomepageBloc _bloc;

  MyHomePage(this._bloc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather"),
      ),
      body: Container(
          margin: EdgeInsets.all(16),
          child: StreamBuilder(
            stream: _bloc.state,
            initialData: homePage.State.loading(),
            builder: (BuildContext context,
                    AsyncSnapshot<homePage.State> snapshot) =>
                snapshot.data.join(
                    (ready) => ReadyWidget(ready),
                    (loading) => Center(child: CircularProgressIndicator(),),
                    (error) => homePage.ErrorWidget()),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _bloc.action.add(homePage.Action.refresh()),
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ReadyWidget extends StatelessWidget {
  final homePage.Ready _readyState;

  ReadyWidget(this._readyState);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        TodayWidget(_readyState.todayWeather),
        ForecastWidget(_readyState.forecast)
      ],
    );
  }
}
