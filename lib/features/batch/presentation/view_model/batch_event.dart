import 'package:flutter/foundation.dart';

@immutable
sealed class BatchEvent {}

final class LoadBatchesEvent extends BatchEvent {}

final class CreateBatchEvent extends BatchEvent {
  final String batchName;

  CreateBatchEvent({required this.batchName});
}

final class DeleteBatchEvent extends BatchEvent {
  final String batchId;

  DeleteBatchEvent({required this.batchId});
}
