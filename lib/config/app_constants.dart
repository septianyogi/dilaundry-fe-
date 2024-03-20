class AppConstant {
  static const appName = 'Di Laundry';

  /// ``` Host = '192.168.0.101'
  static const _host = 'http://192.168.0.101.8000';

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
}