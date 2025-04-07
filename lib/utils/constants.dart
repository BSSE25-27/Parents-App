class AppConstants {
  // API Endpoints
  static const String baseUrl = 'https://api.example.com';
  static const String loginEndpoint = '/auth/login';
  static const String signupEndpoint = '/auth/signup';
  static const String childrenEndpoint = '/children';
  static const String journeyEndpoint = '/journeys';
  static const String notificationsEndpoint = '/notifications';
  
  // App Settings
  static const String appName = 'School Van Tracker';
  static const String appVersion = '1.0.0';
  
  // Error Messages
  static const String networkErrorMessage = 'Network error. Please check your connection and try again.';
  static const String authErrorMessage = 'Authentication failed. Please check your credentials and try again.';
  static const String generalErrorMessage = 'Something went wrong. Please try again later.';
  
  // Success Messages
  static const String loginSuccessMessage = 'Login successful!';
  static const String signupSuccessMessage = 'Account created successfully!';
  static const String profileUpdateSuccessMessage = 'Profile updated successfully!';
  
  // Shared Preferences Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String darkModeKey = 'dark_mode';
}

