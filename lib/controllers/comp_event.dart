import 'package:equatable/equatable.dart';
import 'package:waffaq_x/models/mobile/mobile.dart';

abstract class CompEvent extends Equatable{}


class LoadScreenComp extends CompEvent{
  final Mobile mobile;
  LoadScreenComp({required this.mobile});
  @override
  List<Object?> get props => [];
}

class LoadCoversComp extends CompEvent{
  final Mobile mobile;
  LoadCoversComp({required this.mobile});
  @override
  List<Object?> get props => [];
}

class LoadGlassComp extends CompEvent{
  final Mobile mobile;
  LoadGlassComp({required this.mobile});

  @override
  List<Object?> get props => [];
}