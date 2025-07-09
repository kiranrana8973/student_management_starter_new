import 'package:equatable/equatable.dart';

class BatchEntity extends Equatable {
  final String? batchId;
  final String batchName;

  const BatchEntity({this.batchId, required this.batchName});

  // empty constructor for initial state
  const BatchEntity.initial() : batchId = null, batchName = '_empty.string';

  @override
  List<Object?> get props => [batchId, batchName];
}
