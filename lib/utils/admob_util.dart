import 'dart:io';

class AdmobUtils {
  /// Retorna a id do admob do aplicativo
  String getAppId() =>
      Platform.isAndroid ? 'ca-app-pub-1077648445170203~4328167171' : null;

  /// retorna o id do banner
  String getBannerId() =>
      Platform.isAndroid ? 'ca-app-pub-1077648445170203/6506773802' : null;

  /// retorna o id do Interstitial
  String getInterstitialId() => Platform.isAndroid ? null : null;

  /// retorna o id do Interstitial com video
  String getInterstitialVideoId() => Platform.isAndroid ? null : null;

  /*String getAppId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1077648445170203~4328167171';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544~1458002511';
    }
    //para a web
    return null;
  }*/
}
