import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../utils/utils.dart';

const String _LOCALE = "locale";
const String _BRIGHTNESS = "brightness";

class LocalStorage {
  final GetStorage _storage;

  LocalStorage({GetStorage? storage,
  }): _storage = storage ?? GetStorage();

  setLocal(Locale locale) async => await _storage.write(_LOCALE, locale.languageCode);

  Locale getLocale() => Locale(_storage.read(_LOCALE) ?? DEFAULT_LOCALE_LANGUAGE_CODE);


  setBrightness(Brightness brightness) => _storage.write(_BRIGHTNESS, describeEnum(brightness));

  Brightness getBrightness() {
    String brightness =
        _storage.read<String>(_BRIGHTNESS) ?? DEFAULT_BRIGHTNESS;
    if (brightness == describeEnum(Brightness.dark)) return Brightness.dark;
    return Brightness.light;
  }
  bool get getIsLight {
    if(getBrightness().index==0)return true;
    return false;
  }

  ThemeMode getThemeMode() {
    String brightness =
        _storage.read<String>(_BRIGHTNESS) ?? DEFAULT_BRIGHTNESS;
    if (brightness == describeEnum(Brightness.dark)) return ThemeMode.dark;
    return ThemeMode.light;
  }
  clear() async => await _storage.erase();

}
