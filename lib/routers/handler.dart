import 'package:fluro/fluro.dart';
import 'package:weather_app/bloc/bloc_provider.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/pages/cities_page.dart';
import 'package:weather_app/pages/districts_page.dart';
import 'package:weather_app/pages/provinces_page.dart';
import 'package:weather_app/pages/splash_page.dart';
import 'package:weather_app/pages/settings_page.dart';
import 'package:weather_app/pages/weather_page.dart';
import 'package:weather_app/utils/fluro_convert_util.dart';
import 'package:weather_app/utils/logger.dart';

Handler notFoundHandler = Handler(handlerFunc: (_, params) {
  Logger('RouterHandler:').log('Not Found Router');
});

Handler rootHandler = Handler(handlerFunc: (_, params) => SplashPage());

Handler weatherHandler = Handler(handlerFunc: (_, params) {
  String cityId = params['city_id']?.first;
  return BlocProvider(child: WeatherPage(city: cityId), bloc: WeatherBloc());
});

Handler provincesHandler =
    Handler(handlerFunc: (_, params) => ProvinceListPage());

Handler citiesHandler = Handler(handlerFunc: (_, params) {
  String provinceId = params['province_id']?.first;
  String name = params['name']?.first;
  return CityListPage(
      provinceId: provinceId,
      name: FluroConvertUtils.fluroCnParamsDecode(name));
});

Handler districtsHandler = Handler(handlerFunc: (_, params) {
  String provinceId = params['province_id']?.first;
  String cityId = params['city_id']?.first;
  String name = params['name']?.first;
  return DistrictListPage(
      provinceId: provinceId,
      cityId: cityId,
      name: FluroConvertUtils.fluroCnParamsDecode(name));
});

Handler settingsHandler = Handler(handlerFunc: (_, params) => SettingsPage());
