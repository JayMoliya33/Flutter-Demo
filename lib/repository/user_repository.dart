import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/Utils/Constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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
    //currentUser.value = User.fromJSON(json.decode(response.body)['data']);
    print('success');
    return true;
  } else {
    throw new Exception(response.body);
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
    getCurrentUser();
    //  currentUser.value = User.fromJSON(json.decode(response.body)['data']);
    print('success');
    return true;
  } else {
    throw new Exception(response.body);
  }
}

Future<User> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.clear();
  if (currentUser.value.auth == null && prefs.containsKey('current_user')) {
    currentUser.value =
        User.fromJSON(json.decode(await prefs.get('current_user')));
    currentUser.value.auth = true;
  } else {
    currentUser.value.auth = false;
  }
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  currentUser.notifyListeners();
  return currentUser.value;
}

Future<User> updatePassword(User user) async {
  // User _user = userRepo.currentUser.value;
  // final String _apiToken = 'api_token=${_user.apiToken}';
  // user.password = _user.password;
  //final String url = '${GlobalConfiguration().getValue('api_base_url')}delivery_addresses/${address.id}?$_apiToken';
  final client = new http.Client();
  try {
    final response = await client.post(
      Uri.https(Constant.BASE_URL, Constant.RESET_PASSWORD),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(user.toPasswordMap()),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return User.fromJSON(json.decode(response.body));
  } catch (e) {
    return new User.fromJSON({});
  }
}

Future<User> changePassword(User user) async {
  final client = new http.Client();
  try {
    var token = (json.encode(user.toPasswordMap()['token']));
    final response = await client.post(
      Uri.https(Constant.BASE_URL, Constant.CHANGE_PASSWORD),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(user.toPasswordMap()),
    );
    print('Token : $token');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      print('success');
      return User.fromJSON(json.decode(response.body));
    } else {
      throw new Exception(response.body);
    }
  } catch (e) {
    return new User.fromJSON({});
  }
}

Future<void> logout() async {
  currentUser.value = new User();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_user');
}

void setCurrentUser(jsonString) async {
  try {
    if (json.decode(jsonString)['data'] != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'current_user', json.encode(json.decode(jsonString)['data']));
    }
  } catch (e) {
    throw new Exception(e);
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


