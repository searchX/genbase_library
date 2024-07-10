import 'package:flutter/material.dart';
import 'package:genbase/genbase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure plugin services are initialized.
  Genbase.projectKey = '48c7231d-b30f-42d9-88f8-20d65183ecb0';
  Genbase.baseUrl = 'https://genbase.neurotaskai.com'; // Change the Local Url
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
  }

  Future<String> getFunnyJoke(String inputText) async {
    if (inputText.isEmpty) {
      return 'Please enter something';
    }
  
    OpenAIChatCompletionModel completion = await Genbase.openai.chat.create(
      model: 'gpt-3.5-turbo',
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          role: OpenAIChatMessageRole.system,
          content: [
            OpenAIChatCompletionChoiceMessageContentItemModel.text(
                'You are a funny joke generator AI that will help user generate jokes based on their input')
          ]
        ),
        OpenAIChatCompletionChoiceMessageModel(
          role: OpenAIChatMessageRole.user,
          content: [
            OpenAIChatCompletionChoiceMessageContentItemModel.text("User input: $inputText")
          ]
        )
      ]
    );

    return completion.choices.first.message.content?.first.text ?? 'No joke found';
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
          title: const Text('Funny Jokes App'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Tell me what kind of jokes you want',
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48), // fromHeight use double.infinity as width and 40 is the height
                      ),
                      onPressed: () {
                        setState(() {
                          _futureJoke = getFunnyJoke(_controller.text);
                        });
                      },
                      child: const Text('Generate Joke'),
                    ),
                    const SizedBox(height: 8),
                    FutureBuilder<String>(
                      future: _futureJoke,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return const Text('Error occurred!');
                        } else if (snapshot.hasData) {
                          return Text(snapshot.data ?? 'No joke found');
                        } else {
                          return const Text('Enter something and click on generate jokes!');
                        }
                      },
                    ),
                  ],
                ),
                const Text(
                  'Powered by Genbase ❤️',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
