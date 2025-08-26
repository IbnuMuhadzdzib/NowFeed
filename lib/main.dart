import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/splash_page.dart';
import 'controllers/theme_controller.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Inisialisasi notifikasi
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Konfigurasi Android
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher'); 

  // Gabungkan setting
  const InitializationSettings initializationSettings =
      InitializationSettings(
    android: initializationSettingsAndroid,
  );

  // Inisialisasi notifikasi
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        title: 'News App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Tommy',
          brightness: Brightness.light,
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: const Color(0xFFF0544D),
            onPrimary: const Color(0xFFFFFFD8),
            secondary: const Color(0xFFFFFFD8),
            onSecondary: const Color(0xFFF0544D),
            tertiary: const Color(0xFF0F2240),
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
        themeMode: themeController.isDarkMode.value
            ? ThemeMode.dark
            : ThemeMode.light,
        home: SplashPage(),
      ),
    );
  }
}
