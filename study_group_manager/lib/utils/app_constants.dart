class AppConstants {
  // API Configuration
  static const String baseUrl = 'https://api.studygroup.com';
  static const String apiVersion = '/v1';

  // API Endpoints
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String refreshTokenEndpoint = '/auth/refresh';
  static const String logoutEndpoint = '/auth/logout';
  static const String profileEndpoint = '/user/profile';
  static const String studyGroupsEndpoint = '/study-groups';
  static const String uploadsEndpoint = '/uploads';
  static const String filesEndpoint = '/files';

  // Storage Keys (SharedPreferences)
  static const String userTokenKey = 'user_token';
  static const String userRefreshTokenKey = 'user_refresh_token';
  static const String userDataKey = 'user_data';
  static const String isLoggedInKey = 'is_logged_in';
  static const String userIdKey = 'user_id';
  static const String userEmailKey = 'user_email';
  static const String userUsernameKey = 'user_username';
  static const String lastLoginKey = 'last_login';

  // Study Group Categories (matching your image)
  static const String categoryAI = 'AI';
  static const String categoryDEV = 'DEV';
  static const String categoryOS = 'OS';

  static const List<String> allCategories = [
    categoryAI,
    categoryDEV,
    categoryOS,
  ];

  // Category Display Names
  static const Map<String, String> categoryDisplayNames = {
    categoryAI: 'Artificial Intelligence',
    categoryDEV: 'Development',
    categoryOS: 'Operating Systems',
  };

  // File Upload Configuration
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const int maxFileSizeInMB = 10;
  static const List<String> allowedFileTypes = [
    'pdf', 'doc', 'docx', 'txt', 'rtf',
    'png', 'jpg', 'jpeg', 'gif', 'webp',
    'mp4', 'avi', 'mov', 'wmv',
    'zip', 'rar', '7z',
    'ppt', 'pptx', 'xls', 'xlsx'
  ];

  static const List<String> imageTypes = ['png', 'jpg', 'jpeg', 'gif', 'webp'];
  static const List<String> documentTypes = ['pdf', 'doc', 'docx', 'txt', 'rtf'];
  static const List<String> presentationTypes = ['ppt', 'pptx'];
  static const List<String> spreadsheetTypes = ['xls', 'xlsx'];
  static const List<String> videoTypes = ['mp4', 'avi', 'mov', 'wmv'];
  static const List<String> archiveTypes = ['zip', 'rar', '7z'];

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double extraLargePadding = 32.0;

  static const double cardBorderRadius = 12.0;
  static const double buttonBorderRadius = 28.0;
  static const double smallBorderRadius = 8.0;
  static const double largeBorderRadius = 16.0;

  static const double cardElevation = 4.0;
  static const double buttonElevation = 2.0;

  // Text Sizes
  static const double headingFontSize = 24.0;
  static const double titleFontSize = 18.0;
  static const double bodyFontSize = 14.0;
  static const double captionFontSize = 12.0;
  static const double buttonFontSize = 16.0;

  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // Validation Constants
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 128;
  static const int maxUsernameLength = 20;
  static const int minUsernameLength = 3;
  static const int maxEmailLength = 254;
  static const int maxDescriptionLength = 500;
  static const int maxTitleLength = 100;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Network Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // Image Configuration
  static const int maxProfileImageSize = 5 * 1024 * 1024; // 5MB
  static const double profileImageSize = 100.0;
  static const double smallProfileImageSize = 40.0;
  static const double largeProfileImageSize = 120.0;

  // App Information
  static const String appName = 'Study Group Manager';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Manage your study groups with AI, Development, and OS categories';

  // Error Messages
  static const String networkErrorMessage = 'Network error. Please check your connection.';
  static const String serverErrorMessage = 'Server error. Please try again later.';
  static const String unknownErrorMessage = 'Something went wrong. Please try again.';
  static const String loginFailedMessage = 'Login failed. Please check your credentials.';
  static const String registrationFailedMessage = 'Registration failed. Please try again.';
  static const String fileUploadFailedMessage = 'File upload failed. Please try again.';

  // Success Messages
  static const String loginSuccessMessage = 'Login successful!';
  static const String registrationSuccessMessage = 'Registration successful!';
  static const String profileUpdatedMessage = 'Profile updated successfully!';
  static const String fileUploadedMessage = 'File uploaded successfully!';
  static const String fileDeletedMessage = 'File deleted successfully!';

  // Regular Expressions
  static const String emailRegexPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String phoneRegexPattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
  static const String usernameRegexPattern = r'^[a-zA-Z0-9_]{3,20}$';

  // Study Group Constants
  static const int maxStudyGroupMembers = 100;
  static const int maxStudyGroupsPerUser = 50;
  static const int maxTagsPerGroup = 10;
  static const int maxTagLength = 20;

  // Date Formats
  static const String dateFormat = 'yyyy-MM-dd';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String displayDateFormat = 'MMM dd, yyyy';
  static const String displayDateTimeFormat = 'MMM dd, yyyy HH:mm';

  // Cache Settings
  static const Duration cacheExpiration = Duration(hours: 24);
  static const int maxCacheSize = 50 * 1024 * 1024; // 50MB
}