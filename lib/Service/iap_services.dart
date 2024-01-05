
import 'package:in_app_purchase/in_app_purchase.dart';

class IAPServices{

  static final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  static final Set<String> _kIds = <String>{'android.test.purchased','android.test.canceled','android.test.refunded'};

  static Future<void> checkPurchaseComplete()async{
    ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(_kIds);
    print("*****************");
    response.productDetails.forEach((element) {
      print(element.price);
    });
    print("*****************");
    response.notFoundIDs.forEach((element) {
      print(element);
    });
    print("*****************");
  }

  static Future<void> restorePurchase()async{
    await _inAppPurchase.restorePurchases();
  }

}