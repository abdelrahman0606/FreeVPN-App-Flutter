import 'dart:async';

import 'package:get/get.dart';

import '../apis/apis.dart';
import '../helpers/my_dialogs.dart';
import '../helpers/pref.dart';
import '../models/vpn.dart';

class LocationController extends GetxController {
  List<Vpn> vpnList = Pref.vpnList;

  final RxBool isLoading = false.obs;

  Future<void> getVpnData() async {
    isLoading.value = true;
    vpnList.clear();
    
    try {
      vpnList = await APIs.getVPNServers().timeout(
        Duration(seconds: 45),
        onTimeout: () {
          isLoading.value = false;
          MyDialogs.error(msg: 'Loading timeout. Please check your internet connection and try again.');
          return <Vpn>[];
        },
      );
      
      if (vpnList.isEmpty) {
        // Try to use cached list if available
        vpnList = Pref.vpnList;
        if (vpnList.isEmpty) {
          MyDialogs.error(msg: 'No VPN servers available. Please try again later.');
        }
      }
    } catch (e) {
      // Try to use cached list if available
      vpnList = Pref.vpnList;
      if (vpnList.isEmpty) {
        MyDialogs.error(msg: 'Failed to load VPN servers: ${e.toString()}');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
