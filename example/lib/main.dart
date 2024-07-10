import 'package:flutter/material.dart';
import 'package:genbase/genbase.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure plugin services are initialized.
  Genbase.projectKey = '2ed57847-f89a-46a0-8183-ec7b731c0b6f';
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
  final TextEditingController _controller = TextEditingController();
  Future<String>? _futureJoke;

  @override
  void initState() {
    super.initState();
    exampleChat().then(print);
  }

  Future<OpenAIChatCompletionModel> exampleChat() async {
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

  Future<void> exampleImage() async {
    OpenAIImageModel image = await OpenAI.instance.image.create(
      prompt: 'an astronaut on the sea',
      n: 1,
      size: OpenAIImageSize.size1024,
      responseFormat: OpenAIImageResponseFormat.url,
    );

// Printing the output to the console.
    for (int index = 0; index < image.data.length; index++) {
      final currentItem = image.data[index];
      print(currentItem.url);
    }
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
