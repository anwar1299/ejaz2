enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined,
}

class AuthExceptionHandler {
  static handleException(e) {
    print(e.code);
    var status;
    switch (e.code) {
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        status = AuthResultStatus.invalidEmail;
        break;
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        status = AuthResultStatus.wrongPassword;
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        status = AuthResultStatus.userNotFound;
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        status = AuthResultStatus.userDisabled;
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        status = AuthResultStatus.tooManyRequests;
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        status = AuthResultStatus.operationNotAllowed;
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "email-already-in-use":
      case "account-exists-with-different-credential":
        status = AuthResultStatus.emailAlreadyExists;
        break;
      default:
        status = AuthResultStatus.undefined;
    }
    return status;
  }

  ///
  /// Accepts AuthExceptionHandler.errorType
  ///
  static generateExceptionMessage(exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case AuthResultStatus.invalidEmail:
        errorMessage = "Your email address appears to be malformed.";
        break;
      case AuthResultStatus.wrongPassword:
        errorMessage = "Your password is wrong.";
        break;
      case AuthResultStatus.userNotFound:
        errorMessage = "User with this email doesn't exist.";
        break;
      case AuthResultStatus.userDisabled:
        errorMessage = "User with this email has been disabled.";
        break;
      case AuthResultStatus.tooManyRequests:
        errorMessage = "Too many requests. Try again later.";
        break;
      case AuthResultStatus.operationNotAllowed:
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage =
            "The email has already been registered. Please login or reset your password.";
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }

    return errorMessage;
  }
}
