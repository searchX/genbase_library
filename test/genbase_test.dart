import 'package:flutter_test/flutter_test.dart';
import 'package:genbase/genbase.dart';
import 'package:genbase/genbase_platform_interface.dart';
import 'package:genbase/genbase_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGenbasePlatform
    with MockPlatformInterfaceMixin
    implements GenbasePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final GenbasePlatform initialPlatform = GenbasePlatform.instance;

  test('$MethodChannelGenbase is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelGenbase>());
  });

  test('getPlatformVersion', () async {
    Genbase genbasePlugin = Genbase();
    MockGenbasePlatform fakePlatform = MockGenbasePlatform();
    GenbasePlatform.instance = fakePlatform;

    expect(await genbasePlugin.getPlatformVersion(), '42');
  });
}
