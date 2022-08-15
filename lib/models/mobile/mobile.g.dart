// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Mobile _$$_MobileFromJson(Map<String, dynamic> json) => _$_Mobile(
      brandName: json['brandName'] as String,
      mobileId: json['mobileId'] as String,
      mobileName: json['mobileName'] as String,
      displaySize: (json['displaySize'] as num).toDouble(),
      processor: json['processor'] as String,
      storageAndRam: json['storageAndRam'] as String,
      mainCameras: json['mainCameras'] as String,
      selfieCameras: json['selfieCameras'] as String,
      battery: json['battery'] as String,
      os: json['os'] as String,
      hasNotch: json['hasNotch'] as bool,
      curvedDisplay: json['curvedDisplay'] as bool,
    );

Map<String, dynamic> _$$_MobileToJson(_$_Mobile instance) => <String, dynamic>{
      'brandName': instance.brandName,
      'mobileId': instance.mobileId,
      'mobileName': instance.mobileName,
      'displaySize': instance.displaySize,
      'processor': instance.processor,
      'storageAndRam': instance.storageAndRam,
      'mainCameras': instance.mainCameras,
      'selfieCameras': instance.selfieCameras,
      'battery': instance.battery,
      'os': instance.os,
      'hasNotch': instance.hasNotch,
      'curvedDisplay': instance.curvedDisplay,
    };
