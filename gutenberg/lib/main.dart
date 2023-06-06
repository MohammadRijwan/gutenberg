import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app.dart';

void main() async {
  runApp(
    ProviderScope(
      child: ScreenUtilInit(
          designSize: Size(500, 683),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MyApp();
          }),
    ),
  );
}
