import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gutenberg/feature/book/domain/model/book_res_model.dart';
import 'package:gutenberg/feature/book/domain/usecase/app_usecase.dart.dart';

final bookVmProvider = ChangeNotifierProvider.autoDispose<BookVm>((ref) {
  return BookVm();
});

class BookVm extends ChangeNotifier {
  late AuthUseCase _useCase;
  bool isLoading = true;
  String? searchKey;
  int pageNo = 0;
  int count = 32;
  int searchCount = 32;
  List<Result> bookList = [];
  BookResModel? bookResModel;

  BookVm() {
    _useCase = AuthUseCase();
  }

  loadBooks({int pageKey = 1}) async {
    final result = await _useCase.getBooks(pageNo: pageKey);
    result?.when(
      success: (success) {
        bookResModel = success;
        count = bookResModel!.count;
        if (bookResModel!.results.isNotEmpty) {
          bookList.addAll(bookResModel!.results);
          log('${bookResModel!.toJson()}', name: "onData Loading");
          notifyListeners();
          return bookList;
        } else {
          return [];
        }
      },
      failure: (failure) {
        log('$failure', name: "onFailure");
        return [];
      },
    );
  }

  Future<void> onSearch(String value) async {
    log(value, name: "onSearch");
    if (value.isNotEmpty) {
      searchKey = value;
    } else {
      searchKey = null;
    }
    notifyListeners();
  }

  void onClearTap() {
    bookList.clear();
    searchKey = null;
    isSearchEnable = false;
    pageNo = 1;
    notifyListeners();
  }

  Future<List<Result>> fetch(int page) async {
    log('$page', name: "PAGE::::::::");
    if (bookList.length < count) {
      pageNo = pageNo + 1;
      final result = await _useCase.getBooks(pageNo: pageNo);
      result?.when(
        success: (success) {
          bookResModel = success;
          count = bookResModel!.count;
          if (bookResModel!.results.isNotEmpty) {
            bookList.addAll(bookResModel!.results);
            log('${bookResModel!.toJson()}', name: "onData Loading");
            notifyListeners();
            return bookList;
          } else {
            return [];
          }
        },
        failure: (failure) {
          log('$failure', name: "onFailure");
          return [];
        },
      );
      return bookList;
    } else {
      return [];
    }
  }

  Future<List<Result>> onSearchBook(int page) async {
    bookList.clear();
    if (bookList.length < searchCount) {
      final result = await _useCase.onSearchBook(searchKey: searchKey!);
      result?.when(
        success: (success) {
          bookResModel = success;
          searchCount = bookResModel!.count;
          if (bookResModel!.results.isNotEmpty) {
            bookList.addAll(bookResModel!.results);
            log('${bookResModel!.toJson()}', name: "onData Loading");
            notifyListeners();
            return bookList;
          } else {
            return [];
          }
        },
        failure: (failure) {
          log('$failure', name: "onFailure");
          return [];
        },
      );
      return bookList;
    } else {
      return [];
    }
  }

  bool isSearchEnable = false;
  void onSearchTap() {
    isSearchEnable = true;
    notifyListeners();
  }
}
