import 'package:flutter/material.dart';
import 'package:genbase/genbase.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _genbase = Genbase();
  String connection_status = "Not Connected";

  @override
  void initState() {
    super.initState();
    print(_genbase.checkConnection);
    _genbase.checkConnection().then((response) {
      if (response.statusCode == 200) {
        setState(() {
          connection_status = "Connected";
        });
      } else {
        setState(() {
          connection_status = "Not Connected";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Connection Status: $connection_status\n'),
        ),
      ),
    );
  }
}
