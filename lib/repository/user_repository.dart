import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/Utils/Constant.dart';
import 'package:http/http.dart' as http;
import '../model/User.dart';

ValueNotifier<User> currentUser = new ValueNotifier(User());
 FirebaseMessaging _firebaseMessaging;

Future<bool> forgotPassword(User user) async {
  final client = new http.Client();
  final response = await client.post(
    Uri.https(Constant.BASE_URL, Constant.FORGOT_PASSWORD),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toEmailMap()),
  );
  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value = User.fromJSON(json.decode(response.body)['data']);
    print('success');
    return true;
  } else {
   // throw new Exception(response.body);
    print('failed');
    return false;
  }
}

Future<bool> resetPassword(User user) async {
  final client = new http.Client();
  final response = await client.post(
    Uri.https(Constant.BASE_URL, Constant.RESET_PASSWORD),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );
  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value = User.fromJSON(json.decode(response.body)['data']);
    print('success');
    return true;
  } else {
     throw new Exception(response.body);
  }
}

Future<void> logout() async {
  currentUser.value = new User();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // await prefs.remove('current_user');
}

void setCurrentUser(jsonString) async {
  try {
    if (json.decode(jsonString)['data'] != null) {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString('current_user', json.encode(json.decode(jsonString)['data']));
    }
  } catch (e) {
    // print(CustomTrace(StackTrace.current, message: jsonString).toString());
    // throw new Exception(e);
  }
}

String getDeviceToken() {
  _firebaseMessaging = FirebaseMessaging();
  _firebaseMessaging.getToken().then((String _deviceToken) {
    print('token get successfully');
    print('token :' + _deviceToken);
    return _deviceToken;
  }).catchError((e) {
    print('Notification not configured');
    print(e);
  });
  return "";
}