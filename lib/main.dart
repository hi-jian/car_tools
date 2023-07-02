import 'package:flutter/material.dart';
import 'package:car_tools/routes.dart';
import 'package:flutter/services.dart';

void main() {
  // 设置状态栏为透明
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(const MyApp());
}

/// 都有那些功能
/// 1. 应用市场，收集所有应用，并集成下载功能，支持上传发布功能
/// 2. 应用列表，读取本设备软件列表并允许打开卸载功能。

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        ),
      ),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: homeRoute,
      themeMode: ThemeMode.system, // 或 ThemeMode.light 或 ThemeMode.dark

    );
  }
}
