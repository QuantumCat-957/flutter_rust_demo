import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'plugin_demo_platform_interface.dart';

/// An implementation of [PluginDemoPlatform] that uses method channels.
class MethodChannelPluginDemo extends PluginDemoPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('plugin_demo');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
