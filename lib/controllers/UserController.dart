import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/User.dart';
import '../repository/user_repository.dart' as repository;

class UserController {
  User user = new User();

  void forgotPassword() async {
    print('inside forgotPassword usercontroller');
    repository.forgotPassword(user).then((value) {
      if (value != null && value == true) {
        print(value);
      } else {
        print("'Error! Verify email settings',");
      }
    });
  }

  void resetPassword() async {
    print('inside resetPassword userController');
    user.deviceToken = repository.getDeviceToken();
    repository.resetPassword(user).then((value) {
      if (value != null && value == true) {
        print("value = " + value.toString());
      } else {
        print("Error occurred");
      }
    });
  }

  void updatePassword() async {
    print('inside updatePassword userController');
   // user.deviceToken = repository.getDeviceToken();
    repository.updatePassword(user).then((value) {
      if (value != null && value == true) {
        print("value = " + value.toString());
      } else {
        print("Error occurred");
      }
    });
  }

  void changePassword() async {
    print('inside changePassword userController');
    repository.changePassword(user).then((value) {
      if (value != null && value == true) {
        print(value);
      } else {
        print("Error!");
      }
    });
  }

}
