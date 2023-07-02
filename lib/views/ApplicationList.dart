import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

class ApplicationList extends StatefulWidget {
  const ApplicationList({super.key});

  @override
  State<ApplicationList> createState() => _ApplicationListState();
}

class _ApplicationListState extends State<ApplicationList> {
  List<Application> apps = [];
  bool includeAppIcons = true;
  bool includeSystemApps = true;
  bool onlyAppsWithLaunchIntent = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    apps = [];
    setState(() {});
    apps = await DeviceApps.getInstalledApplications(
      includeAppIcons: includeAppIcons, // 包括应用图标
      includeSystemApps: includeSystemApps, // 包括系统应用
      onlyAppsWithLaunchIntent: onlyAppsWithLaunchIntent, // 只包括有启动意图的应用
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('应用列表'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_alt),
            onSelected: (value) {
              if (value == 'includeSystemApps') {
                includeSystemApps = !includeSystemApps;
              } else if (value == 'onlyAppsWithLaunchIntent') {
                onlyAppsWithLaunchIntent = !onlyAppsWithLaunchIntent;
              }
              fetchData();
            },
            itemBuilder: (BuildContext context) => [
              CheckedPopupMenuItem<String>(
                value: 'includeSystemApps',
                checked: includeSystemApps,
                child: const Text('显示系统应用'),
              ),
              CheckedPopupMenuItem<String>(
                value: 'onlyAppsWithLaunchIntent',
                checked: onlyAppsWithLaunchIntent,
                child: const Text('只显示可以打开的应用'),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              onlyAppsWithLaunchIntent = !onlyAppsWithLaunchIntent;
              fetchData();
            },
          ),
        ],
      ),
      body: apps.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: apps.length * 2,
              itemBuilder: (context, index) {
                if (index.isOdd) return const Divider();
                final itemIndex = index ~/ 2;
                Application app = apps[itemIndex];
                Image image = app is ApplicationWithIcon
                    ? Image.memory(
                        app.icon,
                        width: 48,
                        height: 48,
                      )
                    : Image.asset('assets/images/AndroidStudio.png');
                return ListTile(
                  leading: image,
                  title: Text(app.appName),
                  subtitle: Text(app.packageName),
                  trailing: Text(app.enabled ? '已启用' : '已停用'),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(app.appName),
                            // 应用信息
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Text("${app.appName} ${app.versionName ?? "version: ${app.versionCode}"}"),
                                  subtitle: Text(app.packageName),
                                ),
                                ListTile(
                                  title: const Text('时间'),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(DateTime.fromMillisecondsSinceEpoch(app.installTimeMillis).toString()),
                                      Text(DateTime.fromMillisecondsSinceEpoch(app.updateTimeMillis).toString()),
                                    ],
                                  ),
                                ),
                                ListTile(
                                  title: const Text('数据目录'),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${app.dataDir}'),
                                      Text(app.apkFilePath),
                                    ],
                                  ),
                                ),
                                ListTile(
                                  title: Text(app.systemApp ? '系统应用' : '应用'),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(app.enabled ? '已启用' : '已停用'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  if (!app.enabled) return;
                                  DeviceApps.openApp(app.packageName);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('打开'),
                              ),
                              TextButton(
                                onPressed: () {
                                  app.openSettingsScreen();
                                },
                                child: const Text('详细信息'),
                              ),
                              TextButton(
                                onPressed: () {
                                  DeviceApps.uninstallApp(app.packageName);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('卸载'),
                              ),
                            ],
                          );
                        });
                  },
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('操作'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: const Text('打开应用'),
                                onTap: () {
                                  if (!app.enabled) return;
                                  DeviceApps.openApp(app.packageName);
                                  Navigator.of(context).pop();
                                },
                              ),
                              ListTile(
                                title: const Text('详细信息'),
                                onTap: () {
                                  app.openSettingsScreen();
                                  Navigator.of(context).pop();
                                },
                              ),
                              ListTile(
                                title: const Text('卸载应用'),
                                onTap: () {
                                  DeviceApps.uninstallApp(app.packageName);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
    );
  }
}
