import 'package:json_annotation/json_annotation.dart';
import 'package:student_management/features/batch/data/model/batch_api_model.dart';

part 'get_all_batch_dto.g.dart';

@JsonSerializable()
class GetAllBatchDto {
  final bool success;
  final int count;
  final List<BatchApiModel> data;

  const GetAllBatchDto({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllBatchDtoToJson(this);

  factory GetAllBatchDto.fromJson(Map<String, dynamic> json) =>
      _$GetAllBatchDtoFromJson(json);
}
