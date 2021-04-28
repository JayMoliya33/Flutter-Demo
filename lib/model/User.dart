class User {
  String firstName;
  String lastName;
  String email;
  String password;
  String passwordConfirmation;
  String deviceToken;
  String deviceType;

  // used for indicate if client logged in or not
  bool auth;

  User();

  User.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      firstName = jsonMap['first_name'] != null ? jsonMap['first_name'] : '';
      lastName = jsonMap['last_name'] != null ? jsonMap['last_name'] : '';
      email = jsonMap['email'] != null ? jsonMap['email'] : '';
      deviceType = jsonMap['device_type'];
      deviceToken = jsonMap['device_token'];
    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["first_name"] = firstName;
    map["last_name"] = lastName;
    map["email"] = email;
    map["password"] = password;
    map["password_confirmation"] = passwordConfirmation;
    if (deviceToken != null) {
      map["device_token"] = deviceToken;
    }
    map["device_type"] = deviceType;
    return map;
  }

  Map toEmailMap() {
    var map = new Map<String, dynamic>();
    map["first_name"] = firstName;
    map["last_name"] = lastName;
    map["email"] = email;
    map["password"] = password;
    map["password_confirmation"] = passwordConfirmation;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}