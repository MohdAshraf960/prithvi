class Validator {
  static String? requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    return null;
  }

  static bool isEmail(String input) {
    final emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
      caseSensitive: false,
    );
    return emailRegex.hasMatch(input);
  }

  static bool isMobileNumber(String input) {
    final mobileRegex = RegExp(
      r'^\+?[0-9]+$',
      caseSensitive: false,
    );
    return mobileRegex.hasMatch(input);
  }
}
