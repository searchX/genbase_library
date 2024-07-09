import 'package:flutter/material.dart';
import 'package:genbase/genbase.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure plugin services are initialized.
  Genbase.projectKey = 'fe48929e-4ea4-4231-ab1c-53850cde9e3d';
  Genbase.baseUrl = 'http://192.168.1.11:8000'; // Change the Local Url
  await Genbase.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    sample().then(print);
  }

  Future<OpenAIChatCompletionModel> sample() async {
    OpenAIChatCompletionModel completion =
        await Genbase.openai.chat.create(model: 'gpt-3.5-turbo', messages: [
      OpenAIChatCompletionChoiceMessageModel(
          role: OpenAIChatMessageRole.assistant,
          content: [
            OpenAIChatCompletionChoiceMessageContentItemModel.text(
                'Hello, how are you?')
          ])
    ]);
    return completion;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Connection Status: '),
        ),
      ),
    );
  }
}
