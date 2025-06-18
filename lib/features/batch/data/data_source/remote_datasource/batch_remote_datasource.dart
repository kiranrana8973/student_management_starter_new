import 'package:dio/dio.dart';
import 'package:student_management/app/constant/api_endpoints.dart';
import 'package:student_management/core/network/api_service.dart';
import 'package:student_management/features/batch/data/data_source/batch_datasource.dart';
import 'package:student_management/features/batch/data/dto/get_all_batch_dto.dart';
import 'package:student_management/features/batch/data/model/batch_api_model.dart';
import 'package:student_management/features/batch/domain/entity/batch_entity.dart';

class BatchRemoteDatasource implements IBatchDataSource {
  final ApiService _apiService;

  BatchRemoteDatasource({required ApiService apiService})
    : _apiService = apiService;

  @override
  Future<void> addBatch(BatchEntity batch) async {
    try {
      final batchApiModel = BatchApiModel.fromEntity(batch);

      var response = await _apiService.dio.post(
        ApiEndpoints.createBatch,
        data: batchApiModel.toJson(),
      );

      if (response.statusCode == 201) {
        return;
      } else {
        // Handle unexpected status codes
        throw Exception('Failed to add batch: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      // Handle DioException
      throw Exception('Failed to add batch: ${e.message}');
    } catch (e) {
      // Handle other exceptions
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<void> deleteBatch(String batchId, String? token) async {
    try {
     final response = await _apiService.dio.delete(
        '${ApiEndpoints.deleteBatch}/$batchId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        // Handle unexpected status codes
        throw Exception('Failed to delete batch: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      // Handle DioException
      throw Exception('Failed to delete batch: ${e.message}');
    } catch (e) {
      // Handle other exceptions
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<List<BatchEntity>> getBatches() async {
    try {
      final response = await _apiService.dio.get(ApiEndpoints.getAllBatch);
      if (response.statusCode == 200) {
        GetAllBatchDto getAllBatchDTO = GetAllBatchDto.fromJson(response.data);
        return BatchApiModel.toEntityList(getAllBatchDTO.data);
      } else {
        // Handle unexpected status codes
        throw Exception('Failed to fetch batches: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      // Handle DioException
      throw Exception('Failed to fetch batches: ${e.message}');
    } catch (e) {
      // Handle other exceptions
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
