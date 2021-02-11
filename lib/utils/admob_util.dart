import 'dart:io';

class AdmobUtil {
  /// Class responsible for controlling or having the id information used for
  /// ads.

  // My Ids android
  // appId: ca-app-pub-1077648445170203~4328167171
  // bannerId: ca-app-pub-1077648445170203/6506773802

  // Ids Test
  // appId Android: ca-app-pub-3940256099942544~3347511713
  // appID iOS: ca-app-pub-3940256099942544~1458002511

  static String getAppId() =>
      Platform.isAndroid ? 'ca-app-pub-1077648445170203~4328167171' : null;

  static String getBannerId() =>
      Platform.isAndroid ? 'ca-app-pub-1077648445170203/6506773802' : null;
}
