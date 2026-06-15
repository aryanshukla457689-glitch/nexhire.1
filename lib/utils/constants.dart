import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String appName = 'NexHire';
  static const String appTagline = 'AI Powered Job Finder';

  // Screen Titles
  static const String login = 'Login';
  static const String register = 'Register';
  static const String home = 'Home';
  static const String profile = 'Profile';
  static const String chatbot = 'AI Career Chatbot';
  static const String recommendations =
      'AI Job Recommendations';

  // Messages
  static const String loginSuccess =
      'Login Successful';

  static const String registerSuccess =
      'Registration Successful';

  static const String noJobsFound =
      'No jobs found';

  static const String fillAllFields =
      'Please fill all fields';

  static const String somethingWentWrong =
      'Something went wrong';

  // Button Text
  static const String loginButton = 'Login';
  static const String registerButton = 'Register';
  static const String logoutButton = 'Logout';
  static const String searchButton = 'Search Jobs';
  static const String applyButton = 'Apply Now';

  // Padding
  static const double screenPadding = 16.0;
  static const double cardRadius = 12.0;

  // Animation Duration
  static const Duration animationDuration =
  Duration(milliseconds: 300);
}

class AppColors {
  static const Color primary =
      Colors.deepPurple;

  static const Color secondary =
      Colors.deepPurpleAccent;

  static const Color background =
  Color(0xFFF5F5F5);

  static const Color white =
      Colors.white;

  static const Color black =
      Colors.black;

  static const Color grey =
      Colors.grey;

  static const Color success =
      Colors.green;

  static const Color error =
      Colors.red;
}

class AppSizes {
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
  static const double xLarge = 32.0;

  static const double buttonHeight = 55.0;

  static const double iconSize = 24.0;
  static const double avatarRadius = 50.0;
}