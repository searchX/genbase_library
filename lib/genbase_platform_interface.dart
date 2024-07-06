import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'genbase_method_channel.dart';

abstract class GenbasePlatform extends PlatformInterface {
  /// Constructs a GenbasePlatform.
  GenbasePlatform() : super(token: _token);

  static final Object _token = Object();

  static GenbasePlatform _instance = MethodChannelGenbase();

  /// The default instance of [GenbasePlatform] to use.
  ///
  /// Defaults to [MethodChannelGenbase].
  static GenbasePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GenbasePlatform] when
  /// they register themselves.
  static set instance(GenbasePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
