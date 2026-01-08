/// App-wide constants for NDESA Mobile
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'NDESA';
  static const String appVersion = '1.0.0';

  // API
  static const String baseUrl = 'http://localhost:3000/v1';
  static const String apiTimeout = '30';

  // Storage Keys
  static const String keyAccessToken = 'access_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';
  static const String keyUserEmail = 'user_email';
  static const String keyUserRole = 'user_role';
  static const String keyIsLoggedIn = 'is_logged_in';

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // File Upload
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const List<String> allowedImageExtensions = ['jpg', 'jpeg', 'png'];
  static const List<String> allowedDocExtensions = ['pdf', 'doc', 'docx'];

  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 50;
  static const int otpLength = 6;
  static const int otpExpirySeconds = 300; // 5 minutes

  // Phone Format
  static const String phonePrefix = '+62';
  static const String phonePattern = r'^\+628\d{8,12}$';

  // Routes
  static const String routeSplash = '/';
  static const String routeStart = '/start';
  static const String routeLogin = '/login';
  static const String routeRegister = '/register';
  static const String routeVerification = '/verification';
  static const String routeHome = '/home';
  static const String routeKtp = '/kyc/ktp';
  static const String routeSelfie = '/kyc/selfie';
  static const String routeInterest = '/interest';
  static const String routeProfile = '/profile';
  static const String routeJobs = '/jobs';
  static const String routeJobDetail = '/jobs/:id';
}
