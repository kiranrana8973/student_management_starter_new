import 'package:equatable/equatable.dart';
import 'package:student_management/features/batch/domain/entity/batch_entity.dart';

class BatchState extends Equatable {
  final List<BatchEntity> batches;
  final bool isLoading;
  final String? errorMessage;

  const BatchState({
    required this.batches,
    required this.isLoading,
    this.errorMessage,
  });

  const BatchState.initial()
    : batches = const [],
      isLoading = false,
      errorMessage = null;

  BatchState copyWith({
    List<BatchEntity>? batches,
    bool? isLoading,
    String? errorMessage,
  }) {
    return BatchState(
      batches: batches ?? this.batches,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [batches, isLoading, errorMessage];
}
