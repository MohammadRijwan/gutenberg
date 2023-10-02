import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gutenberg/app.dart';
import 'package:gutenberg/core/services/app_router.dart';

final homeVmProvider = ChangeNotifierProvider.autoDispose<HomeVm>((ref) {
  return HomeVm();
});

class HomeVm extends ChangeNotifier {
  List<MenuModel> menuList = [
    MenuModel(iconPath: 'assets/Fiction.svg', title: 'FICTION'),
    MenuModel(iconPath: 'assets/Drama.svg', title: 'DRAMA'),
    MenuModel(iconPath: 'assets/Humour.svg', title: 'HUMOR'),
    MenuModel(iconPath: 'assets/Politics.svg', title: 'POLITICS'),
    MenuModel(iconPath: 'assets/Philosophy.svg', title: 'PHILOSOPHY'),
    MenuModel(iconPath: 'assets/History.svg', title: 'HISTORY'),
    MenuModel(iconPath: 'assets/Adventure.svg', title: 'ADVENTURE'),
  ];

  void onCommonTapped() {
    navigatorKey.currentState!.pushNamed(AppRouter.bookScreen);
  }
}

class MenuModel {
  final String iconPath;
  final String title;
  final String description;

  MenuModel({required this.iconPath, required this.title, required this.description});
}
