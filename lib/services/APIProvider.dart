import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:notes_app/model/notes/NotesResponse.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notes_app/model/storageItem/storageItem.dart';
import 'package:notes_app/model/userAuthResponse/UserAuthResponse.dart';
import 'package:notes_app/services/storageService.dart';
import 'package:notes_app/view/homescreen.dart';

import '../utils/styles.dart';
import 'interceptor/LoggingInterceptor.dart';

class APIProvider {
  var baseAppUrl = 'http://192.168.1.176:8083';
  final _storageService = StorageService();
  var notesResponse = NotesResponse(notesData: [], success: false);
  Dio _dio = Dio();

  APIProvider() {
    BaseOptions options =
        BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
    _dio = Dio(options);
    _dio.interceptors.add(LoggingInterceptor());
  }

  // register user
  Future<UserAuthResponse> registerUser(
      var userName, var password, BuildContext context) async {
    var registerModel = UserAuthResponse();
    var body = {
      "username": userName,
      "password": password,
    };

    try {
      _dio.options.headers['Content-Type'] = 'application/json';
      final response =
          await _dio.post("$baseAppUrl/users/register", data: body);
      if (response.statusCode == 200) {
        registerModel = UserAuthResponse.fromJson(response.data);
        _storageService.deleteAllSecureData();
        _storageService.storeAccessToken(registerModel.userData.toString());
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

  // login user
  Future<UserAuthResponse> loginUser(
      var userName, var password, BuildContext context) async {
    var loginModel = UserAuthResponse();
    var body = {
      "username": userName,
      "password": password,
    };
    var token = await _storageService.readAccessToken();
    try {
      _dio.options.headers['Content-Type'] = 'application/json';
      _dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await _dio.post("$baseAppUrl/users/login", data: body);
      if (response.statusCode == 200) {
        loginModel = UserAuthResponse.fromJson(response.data);
        _storageService.deleteAllSecureData();
        _storageService.storeAccessToken(loginModel.userData.toString());
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

  // getting user notes ..
  Future<NotesResponse> getNotes() async {
    try {
      debugPrint("Entering try ...");
      Response response = await _dio.get('$baseAppUrl/notes');
      notesResponse = NotesResponse.fromJson(response.data);
      debugPrint("Getting response :: ${notesResponse.notesData}");
    } catch (e, stackTrace) {
      debugPrint("Exception occurred: $e stackTrace: $stackTrace");
    }
    return notesResponse;
  }
}
