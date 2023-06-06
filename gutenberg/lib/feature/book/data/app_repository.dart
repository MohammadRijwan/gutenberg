import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gutenberg/core/common/api_result.dart';
import 'package:gutenberg/core/common/dio_client.dart';
import 'package:gutenberg/core/common/dio_network_exceptions.dart';
import 'package:gutenberg/core/constant/api_end_point.dart';

import '../domain/model/book_res_model.dart';

class AppRepository {
  late DioClient _dioClient;
  AppRepository() {
    _dioClient = DioClient(APIEndpoints.baseUrl);
  }

  Future<ApiResult<BookResModel>> getBooks({required int pageNo}) async {
    try {
      final response = await _dioClient.get(
        '${APIEndpoints.books}?page=$pageNo',
        options: Options(headers: {
          "Content-Type": "application/json",
          "Connection": "keep-alive",
        }),
      );
      if (response.statusCode == 200) {
        return ApiResult.success(data: BookResModel.fromJson(response.data));
      } else {
        return const ApiResult.failure(message: 'Something went wrong');
      }
    } catch (e, stack) {
      log('api_status catch : $stack');
      log('api_status catch : $e');
      return ApiResult.networkFailure(
          error: DioNetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<BookResModel>> onSearchBook(
      {required String searchKey}) async {
    try {
      final response = await _dioClient.get(
        '${APIEndpoints.books}?search=$searchKey',
        options: Options(headers: {
          "Content-Type": "application/json",
          "Connection": "keep-alive",
        }),
      );
      if (response.statusCode == 200) {
        return ApiResult.success(data: BookResModel.fromJson(response.data));
      } else {
        return const ApiResult.failure(message: 'Something went wrong');
      }
    } catch (e, stack) {
      log('api_status catch : $stack');
      log('api_status catch : $e');
      return ApiResult.networkFailure(
          error: DioNetworkExceptions.getDioException(e));
    }
  }
}
