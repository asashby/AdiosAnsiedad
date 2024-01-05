import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:quantum/Service/iap_services.dart';
import 'package:quantum/Utils/size_utils.dart';
import 'package:quantum/Widget/primary_button_widget.dart';

import '../Const/const_string.dart';
import '../Utils/custom_text_style.dart';
import '../Widget/screen_layout_widget.dart';

class InAppPurchaseScreen extends StatefulWidget {
  const InAppPurchaseScreen({super.key});

  @override
  State<InAppPurchaseScreen> createState() => _InAppPurchaseScreenState();
}

class _InAppPurchaseScreenState extends State<InAppPurchaseScreen> {

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  final Set<String> _kIds = <String>{'android.test.purchased'};

  streamPurchase(){
    final Stream<List<PurchaseDetails>> purchaseStream = _inAppPurchase.purchaseStream;
    _subscription = purchaseStream.listen((event) {
        for (var element in event) {
          print("Status : ${element.status}");
        }
      },
      onDone: (){
        _subscription.cancel();
      },
      onError: (error){
        print(error.toString());
      }
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    streamPurchase();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayoutWidget(
      title: "PROGRAMA DE CANTIDAD",
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Image.asset(astImgPaymentVectorPng,height: context.screenWidth*0.5,width: context.screenWidth*0.5,),
          const SizedBox(height: 16,),
          Text("Empieza a sentirte mejor",style: CustomTextStyle.primary18_600,),
          const SizedBox(height: 40,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: SvgPicture.asset(astIcHeartHorizontalSvg,height: 12),
              ),
              const SizedBox(width: 8,),
              Expanded(child: Text("Lorem Ipsum es simplemente texto ficticio de"
                  " la impresión y composición tipográfica",style: CustomTextStyle.darkGrey14_400,),
              )
            ],
          ),
          const SizedBox(height: 16,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: SvgPicture.asset(astIcHeartHorizontalSvg,height: 12),
              ),
              const SizedBox(width: 8,),
              Expanded(child: Text("Lorem Ipsum es simplemente texto ficticio de"
                  " la impresión y composición tipográfica",style: CustomTextStyle.darkGrey14_400,),
              )
            ],
          ),
          const Spacer(),
          RichText(
            text: TextSpan(
                text: "Solo ",
                style: CustomTextStyle.primary18_600,
                children: [
                  TextSpan(
                    text: "\$ 99.99/-",
                    style: CustomTextStyle.primary18_600.copyWith(fontSize: 20),
                  )
                ]
            ),
          ),
          const Spacer(),
          RichText(
              text: TextSpan(
                text: "Already Purchased Subscription? ",
                style: CustomTextStyle.darkGrey14_400.copyWith(fontSize: 12),
                children: [
                  TextSpan(
                    text: "Restore Purchase.",
                    style: CustomTextStyle.darkGrey14_400.copyWith(fontWeight: FontWeight.w600,fontSize: 12),
                  )
                ]
              ),
          ),
          const SizedBox(height: 8,),
          PrimaryButtonWidget(
            title: "Continue",
            onTap: ()async{
              // IAPServices.checkPurchaseComplete();
              final response = await _inAppPurchase.queryProductDetails(_kIds);
              print(response.productDetails);
              final status = await _inAppPurchase.buyNonConsumable(purchaseParam: PurchaseParam(productDetails: ProductDetails(
                title: "android.test.purchased",
                id: "android.test.purchased",
                description: "android.test.purchased",
                currencyCode: "US",
                price: "0.99",
                rawPrice: 0.99,
              )));
              if(response.productDetails.isNotEmpty){}
            },
          )
        ],
      ),
    );
  }
}
