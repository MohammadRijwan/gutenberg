import 'package:flutter/material.dart';
import 'package:gutenberg/feature/home/ui/home_screen.dart';

import 'core/constant/colors.dart';
import 'core/constant/font_family.dart';
import 'core/dependency/dependency_injection.dart';
import 'core/services/app_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    setupDependencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gutenberg',
      navigatorKey: navigatorKey,
      onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
      theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          fontFamily: FontFamily.montserrat,
          primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}
