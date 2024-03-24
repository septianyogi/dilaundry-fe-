import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';

class AppConstant {
  static const appName = 'Di Laundry';

  /// ``` Host = '192.168.0.101'
  static const _host = 'http://192.168.0.101:8000';

  /// ``` baseURL = 'http://192.168.0.101.8000/api'
  static const baseURL = '$_host/api';

  /// ``` baseURL = 'http://192.168.0.101.8000/storage'
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
      'view':DView.empty('Home'),
      'icon':Icons.home_filled,
      'label':'Home',
    },
    {
      'view':DView.empty('My Laundry'),
      'icon':Icons.local_laundry_service,
      'label':'My Laundry',
    },
    {
      'view':DView.empty('Account'),
      'icon':Icons.account_circle,
      'label':'Account',
    },
  ];
}
