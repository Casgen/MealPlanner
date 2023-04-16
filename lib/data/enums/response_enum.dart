enum ResponseEnum {
  passwordNotMatched,
  userNotFound,
  success;

  String getMessage() {
    switch (this) {
      case ResponseEnum.passwordNotMatched: return "Password is incorrect!";
      case ResponseEnum.userNotFound: return "User was not found!";
      case ResponseEnum.success: return "Operation successful.";
      default: return "Enum not reocgnized";
    }
  }
}