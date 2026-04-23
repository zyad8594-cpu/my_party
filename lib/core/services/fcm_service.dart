import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:my_party/core/api/api_constants.dart';
import '../api/auth_service.dart';
import '../api/api_service.dart';
import '../utils/utils.dart' show MyPUtils;

// This function must be top-level or static (as required by FCM)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `await Firebase.initializeApp()` if required by your platform.
  debugPrint("Handling a background message: ${message.messageId}");
}

class FCMService extends GetxService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  
  Future<FCMService> init() async {
    // Request permissions for iOS/Android 13+
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) 
    {
      debugPrint('✅ FCMService: إذن الإشعارات ممنوح.');
    } 
    else 
    {
      debugPrint('⚠️ FCMService: إذن الإشعارات مرفوض أو لم يُمنح.');
    }

    // Show notification pop-up even when app is in the FOREGROUND (Android only)
    await _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Set the default FCM notification channel (must match AndroidManifest)
    // This ensures notifications appear in the correct channel on Android 8+
    await _fcm.setAutoInitEnabled(true);

    // In-app (foreground) notification handling
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('🔔 FCMService: رسالة جديدة وهو مفتوح!');
      if (message.notification != null) {
        MyPUtils.showSnackbar(
          message.notification!.title ?? 'إشعار جديد',
          message.notification!.body ?? '',
          position: SnackPosition.TOP,
        );
      }
    });

    // When app is opened from a background notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('📲 FCMService: فتح التطبيق عبر الإشعار: ${message.notification?.title}');
      // Navigate to notifications screen if needed
      // Get.toNamed(AppRoutes.notifications);
    });

    // Automatically update token on init if already logged in
    if (AuthService.token.isNotEmpty) {
      await updateTokenOnBackend();
    }

    return this;
  }

  Future<String?> getToken() async {
    try {
      String? token = await _fcm.getToken();
      debugPrint("FCM Token: $token");
      return token;
    } 
    catch (e) 
    {
      debugPrint("Error getting FCM token: $e");
      return null;
    }
  }

  String _getDeviceType() {
   if(GetPlatform.isAndroid)return 'android';
   if(GetPlatform.isIOS) return 'ios';
   if(GetPlatform.isWeb) return 'web';
   if(GetPlatform.isLinux) return 'linux';
   if(GetPlatform.isWindows) return 'windows';
   if(GetPlatform.isMacOS) return 'macos';
   if(GetPlatform.isFuchsia) return 'fuchsia';
   if(GetPlatform.isMobile) return 'mobile';
   if(GetPlatform.isDesktop) return 'desktop';
   return 'unknown';
  }

  Future<void> updateTokenOnBackend() async 
  {
    if (AuthService.token.isEmpty) return;
    
    String? token = await getToken();
    if (token != null) 
    {
      final apiService = Get.find<ApiService>();
      try {
        final url = '${ApiConstants.baseUrl}/users/fcm-token';
        debugPrint("🚀 FCMService: جاري تسجيل التوكن على: $url");
        
        await apiService.post(url, data: {
          'fcm_token': token,
          'device_type': _getDeviceType(),
        });
        debugPrint("✅ FCMService: تم تسجيل توكن FCM في الخادم بنجاح.");
      } 
      catch (e) 
      {
        debugPrint("❌ FCMService: فشل تسجيل التوكن في الخادم: $e");
      }
    }
  }

  Future<void> clearTokenOnBackend() async {
    if (AuthService.token.isEmpty) return;
    
    String? token = await getToken();
    if (token != null) 
    {
      final apiService = Get.find<ApiService>();
      try {
        // Use custom data for delete if supported, but typically data is not used for delete.
        // Backend expects it in the body for simplicity, so we use post or update the backend to use params.
        // Actually our backend route is router.delete('/fcm-token', ... clientController.removeFCMToken);
        // and removeFCMToken expects it in req.body.
        // Standard Dio delete supports data.
        await apiService.delete('${ApiConstants.baseUrl}/users/fcm-token', data: {'fcm_token': token});
        debugPrint("FCM token successfully removed from backend");
      } 
      catch (e) 
      {
        debugPrint("Failed to remove FCM token from backend: $e");
      }
    }
  }

}
