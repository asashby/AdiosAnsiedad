import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class InAppPurchaseDemo extends StatefulWidget {
  const InAppPurchaseDemo({super.key});

  @override
  State<InAppPurchaseDemo> createState() => _InAppPurchaseDemoState();
}

class _InAppPurchaseDemoState extends State<InAppPurchaseDemo> {

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  final List<String> _productIDs = ["product_id_1", "product_id_2"];

  final Set<String> _kIds = <String>{'android.test.purchased'};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _inAppPurchase.purchaseStream.listen((event) {
      print("product purchase : ${event.length}");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("In app purchase demo"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Buy"),
          onPressed: ()async{
            final status = await _inAppPurchase.buyNonConsumable(purchaseParam: PurchaseParam(productDetails: ProductDetails(
              title: "Consumable",
              id: "consumable",
              description: "A consumable product.",
              currencyCode: "US",
              price: "1.99",
              rawPrice: 1.99,
            )));
            print("Response Status : ${status}");
            final response = await _inAppPurchase.queryProductDetails(_kIds);
            if(response.productDetails.isNotEmpty){

            }
            // await _inAppPurchase.restorePurchases();
          },
        ),
      ),
    );
  }
}