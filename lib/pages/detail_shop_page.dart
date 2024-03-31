// ignore_for_file: unused_import, unnecessary_import, prefer_const_constructors

import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:dilaundry/config/app_assets.dart';
import 'package:dilaundry/config/app_colors.dart';
import 'package:dilaundry/config/app_constants.dart';
import 'package:dilaundry/config/app_format.dart';
import 'package:dilaundry/models/shop_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class DetailShopPage extends StatelessWidget {
  const DetailShopPage({super.key, required this.shop});
  final ShopModel shop;

  launchWA(BuildContext context, String number) async {
    bool? yes = await DInfo.dialogConfirmation(
      context,
      'Chat via Whatsapp',
      'Yes to confirm'
    );
    if(yes??false) {
      final link = WhatsAppUnilink(
        // phoneNumber: number,
        phoneNumber: '6288225403007',
        text: 'Helo, I want to order a laundry service',
      );
      if(await canLaunchUrl(link.asUri())) {
        launchUrl(
          link.asUri(),
          mode: LaunchMode.externalApplication,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          headerImage(context),
          DView.height(10),
          groupItemInfo(context),
          DView.height(20),
          category(),
          DView.height(20),
          description(),
          DView.height(20),
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: ElevatedButton(
              onPressed: () {}, 
              child: Text(
                'Order',
                style: TextStyle(
                  height: 1,
                  color: Colors.white,
                  fontSize: 18),
              )
            ),
          ),
          DView.height(20),
        ],
      ),
    );
  }

  Padding description() {
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DView.textTitle('Description', color: Colors.black87),
              DView.height(8),
              Text(
                shop.description,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
  }

  Padding category() {
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DView.textTitle('Category', color: Colors.black87),
              DView.height(8),
              Wrap(
                spacing: 8,
                children: [
                  'Regular',
                  'Express',
                  'Economical',
                  'Exclusive',
                ].map((e) {
                  return Chip(
                    visualDensity: const VisualDensity(vertical: -4),
                    label: Text(e, style: const TextStyle(height: 1)),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    padding: EdgeInsets.symmetric(horizontal: 2),
                  );
                }).toList(),
              ),
            ],
          ),
        );
  }

  Padding groupItemInfo(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    itemInfo(
                      const Icon(
                        Icons.location_city_rounded,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      shop.city,
                    ),
                    DView.height(6),
                    itemInfo(
                      const Icon(
                        Icons.location_on,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      shop.location,
                    ),
                    DView.height(6),
                    GestureDetector(
                      onTap: () => launchWA(context, shop.whatsapp),
                      child: itemInfo(      
                        Image.asset(
                          AppAssets.wa,
                          width: 20,
                        ),
                        shop.whatsapp,
                      ),
                    ),
                  ],
                ),
              ),
              DView.width(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    AppFormat.longPrice(shop.price),
                    style: const TextStyle(
                      height: 1,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const Text('/kg')
                ],
              )
            ],
          ),
        );
  }

  Widget itemInfo(Widget icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30,
          height: 20,
          alignment: Alignment.centerLeft,
          child: icon
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
            ),
          )
        ),
      ],
    );
  }

  Widget headerImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                '${AppConstant.baseImageURL}/shop/${shop.image}',
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AspectRatio(
                aspectRatio: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [
                        Colors.black,
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    )
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shop.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      DView.height(8),
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating: shop.rate,
                            itemCount: 5,
                            allowHalfRating: true,
                            itemPadding: const EdgeInsets.all(0),
                            unratedColor: Colors.grey[300],
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemSize: 12,
                            onRatingUpdate: (value) {},
                            ignoreGestures: true,
                          ),
                          DView.width(4),
                          Text(
                            '(${shop.rate})',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 11
                            ),
                          ),
                        ],
                      ),
                      !shop.pickup && !shop.delivery
                        ? DView.nothing() 
                        : Padding(
                        padding: const EdgeInsets.only(top: 16), 
                        child: Row(
                          children: [
                            if(shop.pickup) childOrder('Pickup'),
                            if(shop.delivery) DView.width(8),
                            if(shop.delivery) childOrder('Delivery'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 36,
              left: 16,
              child: SizedBox(
                height: 36,
                child: FloatingActionButton.extended(
                  heroTag: 'fab-back-button',
                  onPressed: () => Navigator.pop(context),
                  backgroundColor: Colors.white,
                  extendedIconLabelSpacing: 0,
                  extendedPadding: const EdgeInsets.only(left: 10 ,right: 10),
                  icon: Icon(
                    Icons.navigate_before,
                    color: Colors.black,  
                  ),
                  label: Text(
                    'Back',
                    style: TextStyle(
                      height: 1,
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container childOrder(String name) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.green,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              height: 1,
            ),
          ),
          DView.width(4),
          const Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 14,
          ),
        ],
      ),
    );
  }
}