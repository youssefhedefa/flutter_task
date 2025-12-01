class AppStrings {
  AppStrings._();

  // Auth Strings
  static const String login = 'Login';
  static const String username = 'Username';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String loginButton = 'LOGIN';

  // Validation Messages
  static const String usernameRequired = 'Please enter your username';
  static const String emailRequired = 'Please enter your email';
  static const String emailInvalid = 'Please enter a valid email';
  static const String passwordRequired = 'Please enter your password';

  // API Error Messages
  static const String networkError =
      'No internet connection. Please check your network.';
  static const String timeoutError = 'Request timeout. Please try again.';
  static const String badRequestError = 'Bad request.';
  static const String unauthorizedError = 'Unauthorized. Please login again.';
  static const String forbiddenError =
      'Forbidden. You do not have access to this resource.';
  static const String notFoundError = 'Resource not found.';
  static const String internalServerError =
      'Internal server error. Please try again later.';
  static const String serviceUnavailableError =
      'Service temporarily unavailable. Please try again later.';
  static const String unknownError = 'An unknown error occurred. Please try again.';
  static const String cancelledError = 'Request was cancelled.';

  static const String loginSuccess = 'Login successful';

  static const String loginError = 'Login failed';

  static const String home = 'Home';
  static const String wishlist = 'Wishlist';

  // Categories
  static const String all = 'all';

  static const String youAreInOfflineMode = 'You are in offline mode. Displayed data may be outdated.';
}
