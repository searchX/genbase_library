import 'package:flutter/material.dart';
import 'package:genbase/genbase.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure plugin services are initialized.
  Genbase.projectKey = 'Enter your Project Key'; // Try to use env variables.
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
    exampleModel().then(print);
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

  Future<List<OpenAIModelModel>> exampleModel() async {
    List<OpenAIModelModel> models = await Genbase.openai.model.list();
    OpenAIModelModel firstModel = models.first;
    OpenAIModelModel model =
        await Genbase.openai.model.retrieve("text-davinci-003");

    print(model.ownedBy); // ...

    print(firstModel.id); // ...
    print(firstModel.permission); // ...
    print(models);
    return models;
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
