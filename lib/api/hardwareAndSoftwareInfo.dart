import 'dart:developer';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

class HardSoftWare {

  static final _devicePlugin = DeviceInfoPlugin();
  static String screenX = window.physicalSize.width.toString();
  static String screenY = window.physicalSize.height.toString();
  static Map<String, dynamic> allDetails = {};

  static Future<String> retrieveResolution() async {
    String resolution = screenX + " X " + screenY;
    return resolution;
  }

  static Future<String> androidHardWare() async {
    String hardwar = "";
    if (Platform.isAndroid) {
      final vDetails = await _devicePlugin.androidInfo;
      hardwar = vDetails.hardware;
      return hardwar;
    }
    else if (Platform.isIOS) {
      final vDetails = await _devicePlugin.iosInfo;
      hardwar = vDetails.model;
      return hardwar;
    }
    else {
      throw UnimplementedError();
    }
  }

  static Future<String> retrieveAndroidId() async {
    String id = "";
    if (Platform.isAndroid) {
      final vDetails = await _devicePlugin.androidInfo;
      id = vDetails.androidId;
      return id;
    }
    else if (Platform.isIOS) {
      final vDetails = await _devicePlugin.iosInfo;
      id = vDetails.identifierForVendor;
      return id;
    }
    else {
      throw UnimplementedError();
    }
  }

  static Future<String> getDeviceManuf() async {
    String manuf = "";

    if (Platform.isAndroid) {
      final deviceDetail = await _devicePlugin.androidInfo;
      manuf = deviceDetail.manufacturer.toString() + " " +
          deviceDetail.model.toString();


      return manuf;
    }
    else if (Platform.isIOS) {
      final detailsDev = await _devicePlugin.iosInfo;
      return detailsDev.name;
    }

    else {
      throw UnimplementedError();
    }
  }

  static Future<String> retrieveOS() async {
    return Platform.operatingSystem;
  }

  static Future<String> getDeviceVersion() async {
    String version = "";
    if (Platform.isAndroid) {
      final vDetails = await _devicePlugin.androidInfo;
      version = vDetails.version.sdkInt.toString();
      return version;
    }
    else if (Platform.isIOS) {
      final vDetails = await _devicePlugin.iosInfo;
      version = vDetails.systemVersion;
      return version;
    }
    else {
      throw UnimplementedError();
    }
  }

  static Future<void> getDroidDetails() async {
    Map<String, dynamic> droidDetails;
    try {
      if (Platform.isAndroid) {
        droidDetails = getAdroidInfo(await _devicePlugin.androidInfo);
        dataInfo(droidDetails);
      } else if (Platform.isIOS) {
        //TODO:MYBE!!!
      }
    } on PlatformException {
      droidDetails = <String, dynamic>{
        'ErrorOccured:': 'Failed to get platform version.'
      };
    }
  }


  static Map<String, dynamic> getAdroidInfo(
      AndroidDeviceInfo droidDetails) {
    Map<String, dynamic> droids = {
      'version.securityPatch': droidDetails.version.securityPatch,
      'version.sdkInt': droidDetails.version.sdkInt,
      'version.release': droidDetails.version.release,
      'version.previewSdkInt': droidDetails.version.previewSdkInt,
      'version.incremental': droidDetails.version.incremental,
      'version.codename': droidDetails.version.codename,
      'version.baseOS': droidDetails.version.baseOS,
      'board': droidDetails.board,
      'bootloader': droidDetails.bootloader,
      'brand': droidDetails.brand,
      'device': droidDetails.device,
      'display': droidDetails.display,
      'fingerprint': droidDetails.fingerprint,
      'hardware': droidDetails.hardware,
      'host': droidDetails.host,
      'id': droidDetails.id,
      'manufacturer': droidDetails.manufacturer,
      'model': droidDetails.model,
      'product': droidDetails.product,
      'supported32BitAbis': droidDetails.supported32BitAbis,
      'supported64BitAbis': droidDetails.supported64BitAbis,
      'supportedAbis': droidDetails.supportedAbis,
      'tags': droidDetails.tags,
      'type': droidDetails.type,
      'isPhysicalDevice': droidDetails.isPhysicalDevice,
      'androidId': droidDetails.androidId,
      'systemFeatures': droidDetails.systemFeatures,
    };

    return droids;
  }



  static void dataInfo(Map<String, dynamic> map) {
    for (var val in map.keys) {
      allDetails[val] = map[val];
     // print(val.toString()+" : "+allDetails[val].toString());

    }
  }
  static Map<String, dynamic> getMap(){

    return allDetails;
  }
}





