import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api_constants.dart';

class ConfigService extends GetxService {
  final String _baseUrlKey = 'api_base_url';
  final String _notifEnabledKey = 'notifications_enabled';
  final String _notifSoundKey = 'notification_sound_enabled';
  final String _notifSoundPathKey = 'notification_sound_path';
  final String _notifSoundNameKey = 'notification_sound_name';
  final String _notifSoundTypeKey = 'notification_sound_type';
  
  SharedPreferences? _prefs;
  
  final baseUrl = ''.obs;
  final notificationsEnabled = true.obs;
  final notificationSoundEnabled = true.obs;
  final notificationSoundPath = ''.obs;
  final notificationSoundName = 'Default'.obs;
  final notificationSoundType = 'default'.obs; // default, system, custom

  Future<ConfigService> init() async {
    _prefs = await SharedPreferences.getInstance();
    baseUrl.value = _prefs?.getString(_baseUrlKey) ?? ApiConstants.baseUrl;
    notificationsEnabled.value = _prefs?.getBool(_notifEnabledKey) ?? true;
    notificationSoundEnabled.value = _prefs?.getBool(_notifSoundKey) ?? true;
    notificationSoundPath.value = _prefs?.getString(_notifSoundPathKey) ?? '';
    notificationSoundName.value = _prefs?.getString(_notifSoundNameKey) ?? 'Default';
    notificationSoundType.value = _prefs?.getString(_notifSoundTypeKey) ?? 'default';
    return this;
  }

  Future<void> updateBaseUrl(String newUrl) async {
    if (newUrl.isEmpty) return;
    if (newUrl.endsWith('/')) {
      newUrl = newUrl.substring(0, newUrl.length - 1);
    }
    baseUrl.value = newUrl;
    await _prefs?.setString(_baseUrlKey, newUrl);
  }

  Future<void> setNotificationsEnabled(bool value) async {
    notificationsEnabled.value = value;
    await _prefs?.setBool(_notifEnabledKey, value);
  }

  Future<void> setNotificationSoundEnabled(bool value) async {
    notificationSoundEnabled.value = value;
    await _prefs?.setBool(_notifSoundKey, value);
  }

  Future<void> setNotificationSound(String path, String name, String type) async {
    notificationSoundPath.value = path;
    notificationSoundName.value = name;
    notificationSoundType.value = type;
    await _prefs?.setString(_notifSoundPathKey, path);
    await _prefs?.setString(_notifSoundNameKey, name);
    await _prefs?.setString(_notifSoundTypeKey, type);
  }
}
