import 'package:fluro/fluro.dart';
import 'package:weather_app/utils/db_utils.dart';
import 'package:weather_app/utils/http_utils.dart';

class Application {
  static HttpUtils http; // 全局网络
  static Router router; // 全局路由
  static DatabaseUtils db; // 全局数据库
}
