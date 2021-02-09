import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:rigntfuel/utils/admob_util.dart';

class AdmobWidget {
  final _context;

  AdmobWidget(this._context);

  get context => this._context;

  Widget getBanner(AdmobBannerSize size) {
    return AdmobBanner(
      adUnitId: AdmobUtils().getBannerId(),
      adSize: size,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        handleEvent(event, args, 'Banner');
      },
    );
  }

  AdmobInterstitial getInterstitial() {
    return AdmobInterstitial(
      adUnitId: AdmobUtils().getInterstitialId(),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        //if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleEvent(event, args, 'Interstitial');
      },
    );
  }

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        showSnackBar('New Admob $adType Ad loaded!');
        break;
      case AdmobAdEvent.opened:
        showSnackBar('Admob $adType Ad opened!');
        break;
      case AdmobAdEvent.closed:
        showSnackBar('Admob $adType Ad closed!');
        break;
      case AdmobAdEvent.failedToLoad:
        showSnackBar('Admob $adType failed to load. :(');
        break;
      case AdmobAdEvent.rewarded:
        showDialog(
          context: _context.scaffoldState.currentContext,
          builder: (BuildContext context) {
            return WillPopScope(
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Reward callback fired. Thanks Andrew!'),
                    Text('Type: ${args['type']}'),
                    Text('Amount: ${args['amount']}'),
                    Container(
                      child: getBanner(AdmobBannerSize.BANNER),
                    ),
                  ],
                ),
              ),
              onWillPop: () async {
                _context.scaffoldState.currentState.hideCurrentSnackBar();
                return true;
              },
            );
          },
        );
        break;
      default:
    }
  }

  void showSnackBar(String content) {
    _context.scaffoldState.currentState.showSnackBar(
      SnackBar(
        content: Text(content),
        duration: Duration(milliseconds: 1500),
      ),
    );
  }
}
