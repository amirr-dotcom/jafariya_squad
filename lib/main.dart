import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'providers/auth_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAn5ddd8zsttQZL2vhzXgnhh7xJd-BK9h4",
      authDomain: "jafariya-squad.firebaseapp.com",
      projectId: "jafariya-squad",
      storageBucket: "jafariya-squad.firebasestorage.app",
      messagingSenderId: "819253858668",
      appId: "1:819253858668:web:c8e9685fdeba64331de349",
      measurementId: "G-JZGV3D4TL1",
    ),
  );

  runApp(const JafariyaSquadApp());
}

class JafariyaSquadApp extends StatelessWidget {
  const JafariyaSquadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Jafariya Squad',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(
                  0xFFD32F2F,
                ), // Red color for Islamic theme
                brightness: Brightness.light,
              ),
              textTheme: GoogleFonts.poppinsTextTheme(),
              fontFamily: 'Poppins',
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFFD32F2F),
                brightness: Brightness.dark,
              ),
              textTheme: GoogleFonts.poppinsTextTheme(),
              fontFamily: 'Poppins',
            ),
            themeMode: themeProvider.themeMode,
            builder: (context, child) => child!,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
