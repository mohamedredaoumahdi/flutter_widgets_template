import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/widgets.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const WidgetLibraryApp());
}

class WidgetLibraryApp extends StatefulWidget {
  const WidgetLibraryApp({super.key});

  @override
  State<WidgetLibraryApp> createState() => _WidgetLibraryAppState();
}

class _WidgetLibraryAppState extends State<WidgetLibraryApp> {
  bool _isDark = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Widget Library',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: HomeScreen(
        isDark: _isDark,
        onThemeToggle: () => setState(() => _isDark = !_isDark),
      ),
    );
  }
}