import 'package:flutter_base/models/entities/tale/tale_entity.dart';
import 'package:flutter_base/models/response/api_response.dart';
import 'package:flutter_base/network/api_client.dart';

abstract class TaleRepository {
  Future<ApiResponse> getTales({required int page});
}

class TaleRepositoryImpl extends TaleRepository {
  ApiClient apiClient;

  TaleRepositoryImpl({required this.apiClient});

  @override
  Future<ApiResponse> getTales({required int page}) async {
    return await apiClient.getTales();
  }
}
