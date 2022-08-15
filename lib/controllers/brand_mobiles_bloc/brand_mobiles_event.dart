

import 'package:equatable/equatable.dart';

abstract class BrandMobilesEvent extends Equatable{}

class LoadBrandMobiles extends BrandMobilesEvent{
  final String brandName;
  LoadBrandMobiles({required this.brandName});

  @override
  List<Object?> get props => [];
}