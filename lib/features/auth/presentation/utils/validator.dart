class InputValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email is required";
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(value)) return "Enter a valid email";
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.length < 6) return "Password too short";
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Name is required";
    }
    if (value.length < 3) {
      return "Name must be at least 3 characters";
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "Confirm Password is required";
    }
    if (value != password) {
      return "Passwords do not match";
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone number is required";
    }
    if (value.length < 10) {
      return "invalid phone";
    }
    return null;
  }
}
