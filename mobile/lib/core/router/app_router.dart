import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Auth screens
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/otp_verification_screen.dart';

// KYC screens
import '../../features/kyc/presentation/screens/ktp_upload_screen.dart';
import '../../features/kyc/presentation/screens/selfie_upload_screen.dart';

// Main screens
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/vacancy/presentation/screens/vacancy_screen.dart';
import '../../features/notification/presentation/screens/notification_screen.dart';
import '../../features/ai/presentation/screens/ai_chat_screen.dart';
import '../../features/profile/presentation/screens/cv_screen.dart';
import '../../features/profile/presentation/screens/cv_screen.dart';
import '../../features/home/presentation/screens/village_fund_screen.dart';
import '../../features/home/presentation/screens/progress_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../presentation/main_screen.dart';

/// App Router Configuration
///
/// Menggunakan GoRouter untuk navigation
/// Semua routes didefinisikan di sini
final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    // Authentication routes
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
    GoRoute(
      path: '/verify-otp',
      builder: (context, state) {
        final email = state.extra as String? ?? 'user@example.com';
        return OtpVerificationScreen(email: email);
      },
    ),

    // KYC routes
    GoRoute(path: '/kyc/ktp', builder: (context, state) => const KtpUploadScreen()),
    GoRoute(path: '/kyc/selfie', builder: (context, state) => const SelfieUploadScreen()),

    // Main app routes with Shell (Persistent Bottom Navigation)
    ShellRoute(
      builder: (context, state, child) {
        return MainScreen(location: state.uri.path, child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              path: 'village-fund',
              builder: (context, state) => const VillageFundScreen(),
            ),
            GoRoute(
              path: 'progress',
              builder: (context, state) => const ProgressScreen(),
            ),
          ],
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        // Placeholder routes
        GoRoute(
          path: '/lowongan',
          builder: (context, state) => const VacancyScreen(),
        ),
        GoRoute(
          path: '/ai',
          builder: (context, state) => const AiChatScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      path: '/cv',
      builder: (context, state) => const CvScreen(),
    ),
  ],

  // Error handling
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 80, color: Colors.red),
          const SizedBox(height: 16),
          Text('Halaman tidak ditemukan', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(state.uri.path, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 24),
          ElevatedButton(onPressed: () => context.go('/login'), child: const Text('Kembali ke Login')),
        ],
      ),
    ),
  ),
);
