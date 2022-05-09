import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:notes_app/model/notes/NotesResponse.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notes_app/model/login/loginModel.dart';
import 'package:notes_app/model/register/registerModel.dart';
import 'package:notes_app/model/storageItem/storageItem.dart';
import 'package:notes_app/services/storageService.dart';
import 'package:notes_app/view/homescreen.dart';

import '../utils/styles.dart';

class APIProvider {
  var baseAppUrl = 'http://192.168.1.176:8083';
  final _storageService = StorageService();

  void getNotes() async {
    var notesList = [];
    try {
      debugPrint("entering try ...");
      final response = await http.get(Uri.parse("$baseAppUrl/notes"));
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        notesList = json.decode(response.body);
        debugPrint("getting data :: $notesList");
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    } catch (e) {
      debugPrint("Catches exception :: ${e.toString()}");
    }
  }

  // login user
  Future<LoginModel> loginUser(
      var userName, var password, BuildContext context) async {
    var loginModel = LoginModel();
    var body = {
      "username": userName,
      "password": password,
    };
    var token = await _storageService.readAccessToken();
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    try {
      final response = await http.post(Uri.parse("$baseAppUrl/users/login"),
          body: json.encode(body), headers: header);
      if (response.statusCode == 200) {
        loginModel = LoginModel.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        _storageService.deleteAllSecureData();
        _storageService.storeAccessToken(loginModel.data.toString());
        WidgetProvider().showSnackBar('User Logged In !!', context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        return loginModel;
      } else {
        debugPrint('Failed to login the user');
      }
    } catch (e) {
      debugPrint('Login Exception :: ${e.toString()}');
    }
    return loginModel;
  }

  // register user
  Future<RegisterModel> registerUser(
      var userName, var password, BuildContext context) async {
    var registerModel = RegisterModel();
    var body = {
      "username": userName,
      "password": password,
    };
    var header = {"Content-Type": "application/json"};

    try {
      final response = await http.post(Uri.parse("$baseAppUrl/users/register"),
          body: json.encode(body), headers: header);
      if (response.statusCode == 200) {
        registerModel = RegisterModel.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        _storageService.deleteAllSecureData();
        _storageService.storeAccessToken(registerModel.data.toString());
        WidgetProvider().showSnackBar('User Registered !!', context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        return registerModel;
      } else {
        debugPrint('Failed to register the user');
      }
    } catch (e) {
      debugPrint('Register Exception :: ${e.toString()}');
    }

    return registerModel;
  }
}
