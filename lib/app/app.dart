import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../utils/theme.dart';
import 'routes.dart';

import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/jobs/job_search_screen.dart';
import '../screens/jobs/job_detail_screen.dart';
import '../screens/ai/chatbot_screen.dart';
import '../screens/ai/ai_recommendation_screen.dart';
import '../screens/profile/profile_screen.dart';

class NexHireApp extends StatefulWidget {
  const NexHireApp({super.key});

  @override
  State<NexHireApp> createState() => _NexHireAppState();
}

class _NexHireAppState extends State<NexHireApp> {
  final Future<FirebaseApp> _firebaseInit = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NexHire',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: FutureBuilder(
        future: _firebaseInit,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            debugPrint("Firebase init error: ${snapshot.error}");
            return const LoginScreen();
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return const LoginScreen();
          }

          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
      routes: {
        AppRoutes.register: (context) => const RegisterScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.jobSearch: (context) => const JobSearchScreen(),
        AppRoutes.jobDetail: (context) => const JobDetailScreen(),
        AppRoutes.chatbot: (context) => const ChatbotScreen(),
        AppRoutes.aiRecommendation: (context) => const AIRecommendationScreen(),
        AppRoutes.profile: (context) => const ProfileScreen(),
      },
    );
  }
}
