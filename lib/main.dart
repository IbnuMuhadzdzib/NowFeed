import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/splash_page.dart';
import 'controllers/news_controller.dart';
import 'controllers/theme_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());
  
  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Tommy',
        brightness: Brightness.light,
        colorScheme: ColorScheme(
          brightness: Brightness.light, 
          primary: Color(0xFFF0544D), 
          onPrimary: Color(0xFFFFFFD8),

          secondary: Color(0xFFFFFFD8), 
          onSecondary: Color(0xFFF0544D),

          tertiary: Color(0xFF0F2240),
          onTertiary: Colors.white,


          error: Colors.red, 
          onError: Colors.white, 

          surface: Colors.grey[200]!, 
          onSurface: Colors.black,
          ),

        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.secondary,
          elevation: 2,
        ),
      ),
      themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      home: SplashPage(),
    ));
  }
}
