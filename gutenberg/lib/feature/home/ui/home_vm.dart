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
    MenuModel(iconPath: 'assets/Fiction.svg', title: 'FICTION',description:'This option give you fiction information' ),
    MenuModel(iconPath: 'assets/Drama.svg', title: 'DRAMA', description:'This options give you drams information' ),
    MenuModel(iconPath: 'assets/Humour.svg', title: 'HUMOR',description:'This option give you humor information'),
    MenuModel(iconPath: 'assets/Politics.svg', title: 'POLITICS'description:'This option give you politics information'),
    MenuModel(iconPath: 'assets/Philosophy.svg', title: 'PHILOSOPHY',description:'This option give you philosophy information'),
    MenuModel(iconPath: 'assets/History.svg', title: 'HISTORY',description:'This option give you history information'),
    MenuModel(iconPath: 'assets/Adventure.svg', title: 'ADVENTURE',description:'This option give you adventure information'),
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
