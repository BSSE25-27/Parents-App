import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:school_van_tracker/providers/auth_provider.dart';
import 'package:school_van_tracker/providers/child_provider.dart';
import 'package:school_van_tracker/providers/notification_provider.dart';
import 'package:school_van_tracker/providers/theme_provider.dart';
import 'package:school_van_tracker/screens/login_screen.dart';
import 'package:school_van_tracker/screens/welcome_screen.dart';
import 'package:school_van_tracker/screens/track_child_screen.dart';
import 'package:school_van_tracker/screens/settings_screen.dart';
import 'package:school_van_tracker/screens/qr_scanner_screen.dart';
import 'package:school_van_tracker/screens/notifications_screen.dart';
import 'package:school_van_tracker/screens/signup_screen.dart';
import 'package:school_van_tracker/screens/splash_screen.dart';
import 'package:school_van_tracker/screens/forgot_password_screen.dart';
import 'package:school_van_tracker/screens/journey_history_screen.dart';
import 'package:school_van_tracker/screens/my_children_screen.dart';
import 'package:school_van_tracker/services/notification_service.dart';
import 'package:school_van_tracker/utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Load environment variables (disabled for now)
  // await dotenv.load(fileName: "assets/.env");

  // Initialize notification service (ensure it's working without dotenv)
  // await NotificationService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ChildProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'School Van Tracker',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            initialRoute: '/welcome', // <-- Set to WelcomeScreen
            routes: {
              '/splash': (context) => const SplashScreen(),
              '/welcome': (context) => const WelcomeScreen(),
              '/login': (context) => const LoginScreen(),
              '/signup': (context) => const SignupScreen(),
              '/track': (context) => const TrackChildScreen(),
              '/settings': (context) => const SettingsScreen(),
              '/qr_scanner': (context) => const QRScannerScreen(),
              '/notifications': (context) => const NotificationsScreen(),
              '/forgot-password': (context) => const ForgotPasswordScreen(),
              '/journey-history': (context) => const JourneyHistoryScreen(),
              '/my-children': (context) => const MyChildrenScreen(),
            },
          );
        },
      ),
    );
  }
}
