
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mobile.freezed.dart';
part 'mobile.g.dart';

@freezed
class Mobile with _$Mobile{

  factory Mobile({
    required String brandName,

    required String mobileId,
    required String mobileName,
    required double displaySize,
    required String processor,
    required String storageAndRam,
    required String mainCameras,
    required String selfieCameras,
    required String battery,
    required String os,
    required bool hasNotch,
    required bool curvedDisplay,
  }) = _Mobile;

  factory Mobile.fromJson(Map<String, dynamic> map) => _$MobileFromJson(map);
}