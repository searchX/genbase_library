# Genbase Client Package

## Overview

The Genbase client package enables developers to communicate with the hosted/shared Genbase server and integrate the power of state-of-the-art AI models into their Dart/Flutter applications. This library provides simple and intuitive methods for making requests to various AI model APIs, including the GPT-3 language model, DALL-E image generation, and more.

The package is designed to be lightweight and easy to use, allowing developers to focus on building their applications rather than dealing with backend complexities and errors. Genbase provides a ready-made backend, enabling developers to concentrate on frontend development.

## Features

- **Seamless Integration**: Easily integrate powerful AI models into your Dart/Flutter applications.
- **Multiple AI Models**: Access a variety of APIs, including GPT-3 for language processing and DALL-E for image generation.
- **Lightweight and Easy to Use**: Focus on building your application without worrying about backend complexities and errors.
- **Ready-Made Backend**: Utilize the provided backend to streamline development and focus on frontend application logic.

## Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  genbase_client: ^1.0.0
```

Then run `flutter pub get` to install the package.

## Usage

### Initialize Genbase App

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure plugin services are initialized.
  Genbase.projectKey = "<Enter the project Key>";
  Genbase.baseUrl = 'http://<genbase-server-url>'; // Change to your Genbase server URL
  await Genbase.initialize();
  runApp(MyApp());
}
```

### Models

#### List Models

Lists the currently available models and provides information about each one, such as the owner and availability.

```dart
List<OpenAIModelModel> models = await Genbase.openai.model.list();
OpenAIModelModel firstModel = models.first;

print(firstModel.id); // ...
print(firstModel.permission); // ...
```

#### Retrieve Model

Retrieves a single model by its ID and gets additional pieces of information about it.

```dart
OpenAIModelModel model = await Genbase.openai.model.retrieve("text-davinci-003");

print(model.ownedBy); // ...
```

> If the model ID you provided does not exist or isn't available for your account, a `RequestFailedException` will be thrown. Check the Error Handling section for more details.

### Completions

#### Create Completion

```dart
OpenAICompletionModel completion = await Genbase.openai.completion.create(
  model: "text-davinci-003",
  prompt: "Dart is a program",
  maxTokens: 20,
  temperature: 0.5,
  n: 1,
  stop: ["\n"],
  echo: true,
  seed: 42,
  bestOf: 2,
);

print(completion.choices.first.text); // ...
```

> If the request failed (e.g., if you provided an invalid model), a `RequestFailedException` will be thrown. Check the Error Handling section for more details.

### Chat (ChatGPT)

#### Create Chat Completion

Creates a predicted completion for a chat message(s) from the provided properties.

```dart
// The system message that will be sent to the request.
final systemMessage = OpenAIChatCompletionChoiceMessageModel(
  content: [
    OpenAIChatCompletionChoiceMessageContentItemModel.text(
      "return any message you are given as JSON.",
    ),
  ],
  role: OpenAIChatMessageRole.assistant,
);

// The user message that will be sent to the request.
final userMessage = OpenAIChatCompletionChoiceMessageModel(
  content: [
    OpenAIChatCompletionChoiceMessageContentItemModel.text(
      "Hello, I am a chatbot created by OpenAI. How are you today?",
    ),
    // Image URL contents are allowed only for models with image support such as GPT-4.
    OpenAIChatCompletionChoiceMessageContentItemModel.imageUrl(
      "https://placehold.co/600x400",
    ),
  ],
  role: OpenAIChatMessageRole.user,
);

// All messages to be sent.
final requestMessages = [
  systemMessage,
  userMessage,
];

// The actual request.
OpenAIChatCompletionModel chatCompletion = await Genbase.openai.chat.create(
  model: "gpt-3.5-turbo-1106",
  responseFormat: {"type": "json_object"},
  seed: 6,
  messages: requestMessages,
  temperature: 0.2,
  maxTokens: 500,
);

print(chatCompletion.choices.first.message); // ...
print(chatCompletion.systemFingerprint); // ...
print(chatCompletion.usage.promptTokens); // ...
print(chatCompletion.id); // ...
```

### Image Edits

Creates an edited or extended image given an original image and a prompt.

```dart
OpenAIImageModel imageEdits = await Genbase.openai.image.edit(
  prompt: 'mask the image with color red',
  image: File(/* IMAGE PATH HERE */),
  mask: File(/* MASK PATH HERE */),
  n: 1,
  size: OpenAIImageSize.size1024,
  responseFormat: OpenAIImageResponseFormat.b64Json,
);

for (int index = 0; index < imageEdits.data.length; index++) {
  final currentItem = imageEdits.data[index];
  print(currentItem.b64Json);
}

```
## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

## Support

If you have any questions or need help, please open an issue on our [GitHub repository](https://github.com/searchX/genbase_library) or contact our support team at hsk@neurotaskai.com.

---

Focus on building your application while leveraging the power of Genbase's AI models. Simplify your development process with our ready-made backend and easy-to-use client library.