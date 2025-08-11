import 'package:finance_tracker/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/auth/login_screen.dart';
// import 'screens/dashboard/dashboard_screen.dart'; // tạo sau
import 'routes/router.dart';

// LIGHT MODE
final lightColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.black87, // hoặc Colors.black87 nếu muốn đồng bộ nhận diện
  brightness: Brightness.light,
).copyWith(
  primary: Colors.black,
  onPrimary: Colors.white,
  background: Colors.grey.shade100,
  onBackground: Colors.black87,
  surface: Colors.white,
  onSurface: Colors.black87,
  error: Colors.red, // đỏ cảnh báo
  onError: Colors.white
);

// DARK MODE
final darkColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.black87, // hoặc Colors.black87 nếu muốn đồng bộ nhận diện
  brightness: Brightness.dark,
).copyWith(
  onPrimary: Colors.white,
  background:  Color.fromARGB(255, 33, 33, 33), // nền chính
  surface: Color.fromARGB(255, 23, 23, 23), // bề mặt card
  onSurface: const Color(0xFFB0B0B0), // text phụ
  onBackground: Colors.white, // text chính
  error: Colors.red, // đỏ cảnh báo
  onError: Colors.white
);

// THEME DATA
final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  textTheme: GoogleFonts.interTextTheme(),
  scaffoldBackgroundColor: lightColorScheme.background,
  cardColor: lightColorScheme.surface
);

final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  textTheme: GoogleFonts.interTextTheme(
    ThemeData.dark().textTheme,
  ),
  scaffoldBackgroundColor: darkColorScheme.background,
  cardColor: darkColorScheme.surface
);

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Finance Tracker Personal',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark, // Tự đổi theo hệ thống (light/dark)
      routerConfig: appRouter,
    );
  }
}
