import 'dart:async';

import 'package:clean_weather/bloc/action.dart' as homePage;
import 'package:clean_weather/bloc/dependency_provider.dart';
import 'package:clean_weather/bloc/my_homepage_bloc.dart';
import 'package:clean_weather/bloc/state.dart' as homePage;
import 'package:clean_weather/ui/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class _MockBLoC extends Mock implements MyHomepageBloc {}
class _MockActionStream extends Mock implements StreamSink<homePage.Action>{}

void main() {
  BehaviorSubject<homePage.State> testState = BehaviorSubject();
  _MockActionStream testAction = _MockActionStream();
  final mockBlock = _MockBLoC();
  setUp((){
    when(mockBlock.state).thenAnswer((_) => testState.stream);
    when(mockBlock.action).thenAnswer((_) => testAction);
  });

  testWidgets("given bloc when state is error then error widget exists", (tester) async {
    await tester.pumpWidget(
        MaterialApp(
          home:  DependencyProvider(
            definitions: [
              Dependency.instance(
                      (_) => mockBlock,
                  MyHomepageBloc)
            ],
            child: MyHomePage(),
          )
        )
    );
    testState.add(homePage.State.error());
    await tester.pump(Duration.zero);

    final errorWidgetFinder = find.text("Faild to fetch data");
    expect(errorWidgetFinder, findsOneWidget);
  });

  testWidgets("given bloc when state is loading then loading widget exists", (tester) async {
    await tester.pumpWidget(
        MaterialApp(
            home:  DependencyProvider(
              definitions: [
                Dependency.instance(
                        (_) => mockBlock,
                    MyHomepageBloc)
              ],
              child: MyHomePage(),
            )
        )
    );
    testState.add(homePage.State.loading());
    await tester.pump(Duration.zero);

    final loadingWidgetFinder = find.byWidgetPredicate((widget) {
      return widget is CircularProgressIndicator;
    });
    expect(loadingWidgetFinder, findsOneWidget);
  });

  testWidgets("given bloc when refresh button is clicked then refresh action sent", (tester) async {
    await tester.pumpWidget(
        MaterialApp(
            home:  DependencyProvider(
              definitions: [
                Dependency.instance(
                        (_) => mockBlock,
                    MyHomepageBloc)
              ],
              child: MyHomePage(),
            )
        )
    );
    testState.add(homePage.State.error());
    await tester.pump(Duration.zero);

    final loadingWidgetFinder = find.byIcon(Icons.refresh);
    await tester.tap(loadingWidgetFinder);
    await tester.pump(Duration.zero);
    verify(testAction.add(any));
  });

  tearDown((){
    testState.close();
    testState = BehaviorSubject();
    reset(mockBlock);
  });
}