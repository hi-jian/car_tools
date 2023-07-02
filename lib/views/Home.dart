import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("4代帝豪工具箱"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/application/market');
                  },
                  child: const Text('应用市场'),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/application/list');
                  },
                  child: const Text('我的应用列表'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
