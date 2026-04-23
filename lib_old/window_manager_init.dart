
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

Future<void> windowManagerInit({
  Size? size
}) async
{
  size = size ?? Size(400, 700);
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: size,
    center: true,
    maximumSize: size,
    minimumSize: size,
    backgroundColor: Colors.transparent,
    title: 'تطبيق مناسابتي',
    titleBarStyle: TitleBarStyle.normal,
    windowButtonVisibility: false,
  );
  // تعيين خيارات النافذة
  
  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
}