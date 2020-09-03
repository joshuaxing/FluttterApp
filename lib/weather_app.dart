/*
 * @Author: your name
 * @Date: 2020-09-02 17:45:38
 * @LastEditTime: 2020-09-02 18:02:23
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \weather_app\lib\weather_app.dart
 */
import 'package:flutter/material.dart';
import 'package:weather_app/bloc/bloc_provider.dart';
import 'package:weather_app/bloc/provinces_bloc.dart';
import 'package:weather_app/bloc/settings_bloc.dart';
import 'package:weather_app/configs/application.dart';

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: SettingBloc(), // 主题色切换 BLoC
        child: BlocProvider(
          bloc: ProvincesBloc(), // 城市切换 BLoC
          child: MaterialApp(
            title: 'Weather App',
            onGenerateRoute: Application.router.generator,
            debugShowCheckedModeBanner: false,
          ),
        ));
  }
}
