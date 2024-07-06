#include "include/genbase/genbase_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "genbase_plugin.h"

void GenbasePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  genbase::GenbasePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
