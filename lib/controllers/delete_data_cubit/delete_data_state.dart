

import 'package:equatable/equatable.dart';

abstract class DeleteDataState extends Equatable{}


class DeleteDataInitState extends DeleteDataState{
  @override
  List<Object?> get props => [];
}


class DeletingData extends DeleteDataState{
  @override
  List<Object?> get props => [];
}

class DataDeletedSuccessfully extends DeleteDataState{
  @override
  List<Object?> get props => [];
}

class FailedToDeleteData extends DeleteDataState{
  @override
  List<Object?> get props => [];
}