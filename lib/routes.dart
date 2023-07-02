import 'package:flutter/material.dart';
import 'package:car_tools/views/Home.dart';
import 'package:car_tools/views/ApplicationMarket.dart';
import 'package:car_tools/views/ApplicationList.dart';

const String homeRoute = '/';
const String applicationMarket = '/application/market';
const String applicationList = '/application/list';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => Home());
      case applicationMarket:
        return MaterialPageRoute(builder: (_) => ApplicationMarket());
      case applicationList:
        return MaterialPageRoute(builder: (_) => ApplicationList());
      default:
        return null;
    }
  }
}