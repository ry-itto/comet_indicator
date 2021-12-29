import 'package:comet_indicator/comet_indicator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CometIndicator.simple(
            baseColor: Colors.pinkAccent,
            radius: 100,
            strokeWidth: 3,
            indicatorRatio: 0.7,
            dotRadius: 4,
            duration: const Duration(seconds: 2),
          ),
          CometIndicator.custom(
            indicatorColors: [
              Colors.red,
              Colors.blue,
              Colors.yellow,
              Colors.yellow.withOpacity(0),
            ],
            indicatorColorStops: const [0, 0.2, 0.7, 1.0],
            dotColor: Colors.pinkAccent,
            radius: 100,
            strokeWidth: 3,
            indicatorRatio: 0.5,
            dotRadius: 4,
            duration: const Duration(seconds: 2),
          ),
          CometIndicator.simple(
            baseColor: Colors.pinkAccent,
            radius: 100,
            strokeWidth: 3,
            indicatorRatio: 0.7,
            showsDot: false,
            duration: const Duration(seconds: 2),
          ),
        ],
      ),
    );
  }
}
