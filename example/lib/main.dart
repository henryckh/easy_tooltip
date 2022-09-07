import 'package:easy_tooltip/easy_tooltip.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter EasyTooltip'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              EasyTooltip(
                text: 'hello world!',
                backgroundColor: const Color(0xFF385E9D),
                padding: const EdgeInsets.all(8),
                onEasyTooltipTap: () {
                  debugPrint('child is tapped.');
                },
                onDismiss: () {
                  debugPrint('tooltip is dismissed');
                },
                child: const Icon(Icons.info_outlined),
              ),
            ],
          ),
        ));
  }
}
