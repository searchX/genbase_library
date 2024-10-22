import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'sub_models/choice.dart';
import 'sub_models/usage.dart';

export 'sub_models/choice.dart';
export 'sub_models/usage.dart';

/// {@template openai_edit_model}
/// This class is used to represent an OpenAI edit.
/// {@endtemplate}
@immutable
final class OpenAIEditModel {
  /// The date the edit was [created].
  final DateTime created;

  /// The [choices] generated by the edit.
  final List<OpenAIEditModelChoice> choices;

  /// The [usage] of the edit, if any.
  final OpenAIEditModelUsage? usage;

  /// Weither the edit have at least one choice in [choices].
  bool get haveChoices => choices.isNotEmpty;

  /// Weither the edit have a usage information.
  bool get haveUsage => usage != null;

  @override
  int get hashCode => created.hashCode ^ choices.hashCode ^ usage.hashCode;

  /// {@macro openai_edit_model}
  const OpenAIEditModel({
    required this.created,
    required this.choices,
    required this.usage,
  });

  ///{@macro openai_edit_model}
  /// This method is used to convert a [Map<String, dynamic>] object to a [OpenAIEditModel] object.
  factory OpenAIEditModel.fromMap(Map<String, dynamic> json) {
    return OpenAIEditModel(
      created: DateTime.fromMillisecondsSinceEpoch(json['created'] * 1000),
      choices: (json['choices'] as List)
          .map((e) => OpenAIEditModelChoice.fromMap(e))
          .toList(),
      usage: OpenAIEditModelUsage.fromMap(json['usage']),
    );
  }

  @override
  String toString() =>
      'OpenAIEditModel(created: $created, choices: $choices, usage: $usage)';

  @override
  bool operator ==(covariant OpenAIEditModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.created == created &&
        listEquals(other.choices, choices) &&
        other.usage == usage;
  }
}
