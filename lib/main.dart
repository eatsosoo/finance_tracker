import 'package:finance_tracker/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/auth/login_screen.dart';
// import 'screens/dashboard/dashboard_screen.dart'; // tạo sau
import 'routes/router.dart';
import 'providers/theme_provider.dart';

// LIGHT MODE
final lightColorScheme =
    ColorScheme.fromSeed(
      seedColor:
          Colors.black87, // hoặc Colors.black87 nếu muốn đồng bộ nhận diện
      brightness: Brightness.light,
    ).copyWith(
      primary: Colors.black,
      onPrimary: Colors.white,
      secondary: Colors.orange,
      background: Colors.grey.shade100,
      onBackground: Colors.black87,
      surface: Colors.white,
      onSurface: Colors.black87,
      error: Colors.red, // đỏ cảnh báo
      onError: Colors.white,
    );

// DARK MODE
final darkColorScheme =
    ColorScheme.fromSeed(
      seedColor:
          Colors.black87, // hoặc Colors.black87 nếu muốn đồng bộ nhận diện
      brightness: Brightness.dark,
    ).copyWith(
      primary: Colors.white,
      onPrimary: Colors.black,
      secondary: Colors.orange,
      background: Color.fromARGB(255, 23, 23, 23), // nền chính
      surface: Color.fromARGB(255, 33, 33, 33), // bề mặt card
      onSurface: Color.fromARGB(255, 145, 152, 161), // text phụ
      onBackground: Colors.white, // text chính
      error: Colors.red, // đỏ cảnh báo
      onError: Colors.white,
    );

// THEME DATA
final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  textTheme: GoogleFonts.interTextTheme(),
  scaffoldBackgroundColor: lightColorScheme.background,
  cardTheme: CardThemeData(color: lightColorScheme.surface),
  appBarTheme: AppBarTheme(
    backgroundColor: lightColorScheme.background,
    foregroundColor: lightColorScheme.onBackground,
  ),
  dividerTheme: DividerThemeData(color: Colors.grey.shade200),
  iconTheme: IconThemeData(color: lightColorScheme.primary),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.shade200,
    hintStyle: TextStyle(color: Colors.grey),
    prefixIconColor: Colors.grey,
  ),
  listTileTheme: ListTileThemeData(
    textColor: lightColorScheme.onSurface,
    iconColor: lightColorScheme.onSurface,
  ),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
  scaffoldBackgroundColor: darkColorScheme.background,
  cardTheme: CardThemeData(
    color: darkColorScheme.surface,
    surfaceTintColor: darkColorScheme.onSurface,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: darkColorScheme.background,
    foregroundColor: darkColorScheme.onBackground,
  ),
  dividerTheme: DividerThemeData(color: Colors.grey.shade800),
  iconTheme: IconThemeData(color: darkColorScheme.primary),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.shade800,
    hintStyle: TextStyle(color: Colors.grey),
    prefixIconColor: Colors.grey,
  ),
  listTileTheme: ListTileThemeData(
    textColor: darkColorScheme.onSurface,
    iconColor: darkColorScheme.onSurface,
  ),
);

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp.router(
      title: 'Finance Tracker Personal',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode, // Tự đổi theo hệ thống (light/dark)
      routerConfig: appRouter,
    );
  }
}
