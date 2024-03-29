import 'package:d_view/d_view.dart';
import 'package:dilaundry/pages/dashboard_views/account_view.dart';
import 'package:dilaundry/pages/dashboard_views/home_view.dart';
import 'package:flutter/material.dart';

class AppConstant {
  static const appName = 'DiLaundry';

  /// ``` Host = '192.168.0.102'
  static const _host = 'http://192.168.0.102:8000';

  /// ``` baseURL = 'http://192.168.0.102.8000/api'
  static const baseURL = '$_host/api';

  /// ``` baseURL = 'http://192.168.0.102.8000/storage'
  static const baseImageURL = '$_host/storage';

  static const laundryStatusCategory = [
    'All',
    'Pickup',
    'Queue',
    'Process',
    'Washing',
    'Dried',
    'Ironed',
    'Done',
    'Delivery'
  ];

  static List<Map> navMenuDashboard = [
    {
      'view': const HomeView(),
      'icon':Icons.home_filled,
      'label':'Home',
    },
    {
      'view':DView.empty('My Laundry'),
      'icon':Icons.local_laundry_service,
      'label':'My Laundry',
    },
    {
      'view': const AccountView(),
      'icon':Icons.account_circle,
      'label':'Account',
    },
  ];

  static const homeCategories = [
    'All',
    'Regular',
    'Express',
    'Economical',
    'Exclusive'
  ];
}
