#ifndef FLUTTER_PLUGIN_GENBASE_PLUGIN_H_
#define FLUTTER_PLUGIN_GENBASE_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace genbase {

class GenbasePlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  GenbasePlugin();

  virtual ~GenbasePlugin();

  // Disallow copy and assign.
  GenbasePlugin(const GenbasePlugin&) = delete;
  GenbasePlugin& operator=(const GenbasePlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace genbase

#endif  // FLUTTER_PLUGIN_GENBASE_PLUGIN_H_
