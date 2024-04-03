// ignore_for_file: unnecessary_import, prefer_const_constructors

import 'package:d_view/d_view.dart';
import 'package:dilaundry/config/app_assets.dart';
import 'package:dilaundry/config/app_colors.dart';
import 'package:dilaundry/config/app_format.dart';
import 'package:dilaundry/config/nav.dart';
import 'package:dilaundry/models/laundry_model.dart';
import 'package:dilaundry/pages/detail_shop_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailLaundryPage extends StatelessWidget {
  const DetailLaundryPage({super.key, required this.laundry});
  final LaundryModel laundry;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          headerCover(context),
          DView.height(10),
          Center(
            child: Container(
              height: 4,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey
              ),
            ),
          ),
          DView.height(),
          itemInfo(Icons.sell, AppFormat.longPrice(laundry.total)),
          divider(),
          itemInfo(Icons.event, AppFormat.fullDate(laundry.createdAt)),
          divider(),
          InkWell(
            onTap: () {
              Nav.push(context, DetailShopPage(shop: laundry.shop));
            },
            child: itemInfo(Icons.store, laundry.shop.name)),
          divider(),
          itemInfo(Icons.shopping_basket, '${laundry.weight} kg'),
          divider(),
          if(laundry.withPickup) itemInfo(Icons.shopping_bag, 'Pickup'),
          if(laundry.withPickup) itemDescription(laundry.pickupAddress),
          if(laundry.withPickup) divider(),
          if(laundry.withDelivery)itemInfo(Icons.local_shipping, 'Delivery'),
          if(laundry.withDelivery) itemDescription(laundry.deliveryAddress),
          if(laundry.withDelivery) divider(),
          itemInfo(Icons.description, 'Description'),
          itemDescription(laundry.description),
          divider(),
        ],
      ),
    );
  }

  Widget itemInfo(IconData icon, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary,),
          DView.width(10),
          Text(info)
        ],
      ),
    );
  }

  Widget itemDescription(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Icon(Icons.abc, color: Colors.transparent),
          DView.width(10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black54
              ),
            ),
          ),
        ],
      ),
    );
  }

  Divider divider() {
    return Divider(
      indent: 30,
      endIndent: 30,
      color: Colors.grey[400],
    );
  }

  Padding headerCover(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(10),
          child: AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                      AppAssets.emptyBG,fit: BoxFit.cover,
                    ),                                                                        
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AspectRatio(
                      aspectRatio: 2,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black,
                              Colors.transparent
                            ]
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 60,
                        vertical: 30,
                      ),
                      child: Text(
                        laundry.status,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 40,
                          height: 1,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 36,
                    left: 16,
                    right: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ID : ${laundry.id}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            height: 1,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 6,
                                color: Colors.black45,
                              )
                            ],
                          ),
                        ),
                        FloatingActionButton.small(
                          onPressed: () => Navigator.pop(context),
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.arrow_back, color: Colors.black,),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}