
import 'package:connectivity_plus/connectivity_plus.dart';

// فئة للتحقق من حالة الاتصال بالإنترنت
class NetworkInfo 
{
  static var connectionTextType = 'No Connection'; 
  
  static Connectivity? _connectivity;

  static Connectivity get connectivity 
  {
      if(_connectivity == null)
      {
        _connectivity = Connectivity();
        return _connectivity!;
      }
      else
      {
        return _connectivity!;
      }
  }

  // التحقق من الاتصال بالإنترنت
  static Future<bool> get isConnected async 
  {
    final connectivityResult = await connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  // التحقق من الاتصال بالإنترنت
  static Future<bool> get isNotConnected async => await isConnected;

  // الاستماع لتغيرات حالة الاتصال
  static Stream<ConnectivityResult> get connectivityStream 
  {
    return connectivity.onConnectivityChanged;
  }

  
  // الحصول على نوع الاتصال الحالي
  static Future<ConnectivityResult> get connectionType async 
  {
    var ret = await connectivity.checkConnectivity();
    connectionTextType = convertConnectionTypeToText(ret);
    return ret;
  }

  static Future<String> getConnectionTypeText() async => convertConnectionTypeToText(await connectionType);
  // تحويل نوع الاتصال لنص مقروء
  static String convertConnectionTypeToText(ConnectivityResult result) 
  {
    switch (result) 
    {
      case ConnectivityResult.wifi:
        return 'WiFi';
      case ConnectivityResult.mobile:
        return 'Mobile Data';
      case ConnectivityResult.ethernet:
        return 'Ethernet';
      case ConnectivityResult.vpn:
        return 'VPN';
      case ConnectivityResult.bluetooth:
        return 'Bluetooth';
      case ConnectivityResult.other:
        return 'Other';
      default:
        return 'No Connection';
    }
  }
}