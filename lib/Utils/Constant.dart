class Constant {
  static final String APP_ID = "753903805294529";
  static final String APP_SECRET = "d4ed95d765b7f2007ed2e98099e8c37b";

  // static final String BASE_URL = "https://e3-qkmountain.qkinnovations.com/element3-backend/api/";
  static final String BASE_URL = "https://e3-qkmountain.qkinnovations.com";
  static final String BASE_URL_1 = "element3-backend/api/";

  //Authentication
  static final String LOGIN = "${BASE_URL_1}user/appLogin";
  static final String REGISTER = "${BASE_URL_1}user/appRegistration";
  static final String FORGOT_PASSWORD = "${BASE_URL_1}user/forgetPassword";
  static final String RESET_PASSWORD = "${BASE_URL_1}user/resetPassword";
  static final String LOGOUT = "${BASE_URL_1}user/logout";
  static final String CHANGE_PASSWORD = "${BASE_URL_1}user/changePassword";
}