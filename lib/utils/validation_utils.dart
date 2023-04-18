class ValidationUtils {

  static String? validatePassword(String? value) {
    if (value == null) {
      return "Please provide a password.";
    }

    if (value.isEmpty) {
      return "Please provide a password.";
    }

    return null;
  }

  static String? validateUsername(String? value) {
    RegExp regexp = RegExp(r'^[A-z0-9]\w{5,29}$');

    if (value == null || value.isEmpty) {
      return "Please provide your username.";
    }

    if (value.length < 6) {
      return "Provide a username at least 6 characters long!";
    }

    if (value.length > 29) {
      return "Provide a username shorter than 29 characters!";
    }

    if (!regexp.hasMatch(value)) {
      return "Special characters are not allowed!";
    }

    return null;
  }

}