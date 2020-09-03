/*
 * @Author: your name
 * @Date: 2020-09-02 17:45:38
 * @LastEditTime: 2020-09-02 18:01:22
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \weather_app\lib\pages\settings_page.dart
 */
import 'package:flutter/material.dart';
import 'package:weather_app/bloc/bloc_provider.dart';
import 'package:weather_app/bloc/settings_bloc.dart';
import 'package:weather_app/configs/preferences_key.dart';
import 'package:weather_app/utils/preference_utils.dart';

/// 主题色选择页
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _bloc = BlocProvider.of<SettingBloc>(context);

    return StreamBuilder(
        stream: _bloc.colorStream,
        initialData: _bloc.color,
        builder: (_, AsyncSnapshot<Color> snapshot) => Theme(
              data: ThemeData(
                  primarySwatch: snapshot.data,
                  iconTheme: IconThemeData(color: snapshot.data)),
              child: Scaffold(
                appBar: AppBar(
                  title: Text('设置'),
                ),
                body: Container(
                  color: Colors.black12,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 20.0),
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                          child: StreamBuilder(
                        stream: _bloc.headerStream,
                        initialData: _bloc.sliverHeader,
                        builder: (_, AsyncSnapshot<bool> sliverSnapshot) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('刷新头部是否跟随',
                                  style: TextStyle(
                                      fontSize: 16.0, color: snapshot.data)),
                              Switch(
                                  value: sliverSnapshot.data,
                                  onChanged: (value) {
                                    _bloc.changeSliverState(value);
                                    PreferenceUtils.instance.saveBool(
                                        PreferencesKey.SLIVER_HEADER, value);
                                  })
                            ]),
                      )),
                      SliverPadding(
                        padding: const EdgeInsets.only(right: 12.0),
                        sliver: SliverToBoxAdapter(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('当前主题色：',
                                style: TextStyle(
                                    fontSize: 16.0, color: snapshot.data)),
                            Container(
                                width: 20.0, height: 20.0, color: snapshot.data)
                          ],
                        )),
                      ),
                      SliverPadding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0)),
                      SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                              (_, index) => InkWell(
                                    child: Container(
                                        color: SettingBloc.themeColors[index]),
                                    onTap: () {
                                      _bloc.switchTheme(index);
                                      PreferenceUtils.instance.saveInteger(
                                          PreferencesKey.THEME_COLOR_INDEX,
                                          index);
                                    },
                                  ),
                              childCount: SettingBloc.themeColors.length),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 20.0,
                                  crossAxisSpacing: 20.0)),
                    ],
                  ),
                ),
              ),
            ));
  }
}
