import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:gutenberg/core/common/all.dart';
import 'package:gutenberg/core/common/usecase_result.dart';
import 'package:gutenberg/feature/book/data/app_repository.dart';
import 'package:gutenberg/feature/book/domain/model/book_res_model.dart';

class AuthUseCase {
  late AppRepository _repository;
  AuthUseCase({AppRepository? repository}) {
    _repository = repository ?? GetIt.instance.get<AppRepository>();
  }

  Future<UsecaseResult<BookResModel>?> getBooks({required int pageNo}) async {
    ApiResult<BookResModel> apiResult =
        await _repository.getBooks(pageNo: pageNo);
    UsecaseResult<BookResModel>? useCaseResult;
    apiResult.when(success: (BookResModel? data) async {
      useCaseResult = UsecaseResult.success(data: data);
    }, failure: (String? message) {
      log('usecase $message');
      useCaseResult = UsecaseResult.failure(error: message);
    }, networkFailure: (NetworkExceptions error) {
      log('error $error');
      useCaseResult = UsecaseResult.failure(
          error: NetworkExceptions.getErrorMessage(error));
    });
    return useCaseResult;
  }

  Future<UsecaseResult<BookResModel>?> onSearchBook(
      {required String searchKey}) async {
    ApiResult<BookResModel> apiResult =
        await _repository.onSearchBook(searchKey: searchKey);
    UsecaseResult<BookResModel>? useCaseResult;
    apiResult.when(success: (BookResModel? data) async {
      useCaseResult = UsecaseResult.success(data: data);
    }, failure: (String? message) {
      log('usecase $message');
      useCaseResult = UsecaseResult.failure(error: message);
    }, networkFailure: (NetworkExceptions error) {
      log('error $error');
      useCaseResult = UsecaseResult.failure(
          error: NetworkExceptions.getErrorMessage(error));
    });
    return useCaseResult;
  }
}
