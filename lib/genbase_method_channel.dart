import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'genbase_platform_interface.dart';

/// An implementation of [GenbasePlatform] that uses method channels.
class MethodChannelGenbase extends GenbasePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('genbase');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
