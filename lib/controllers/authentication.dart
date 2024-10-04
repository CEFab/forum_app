import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:forum_app/constants/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthenticationController extends GetxController {
  final isLoading = false.obs;

  Future register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      isLoading(true);

      var data = {
        'name': name,
        'username': username,
        'email': email,
        'password': password,
      };

      var response = await http.post(Uri.parse('${url}register'),
          headers: {'Accept': 'application/json'}, body: data);

      if (response.statusCode == 201) {
        isLoading(false);
        debugPrint(json.decode(response.body));
      } else {
        isLoading(false);
        debugPrint(json.decode(response.body));
      }
    } catch (e) {
      isLoading(false);
      if (kDebugMode) {
        print(e.toString());
      }
    }

    // if (response.statusCode == 200) {
    //   var body = jsonDecode(response.body);
    //   Get.snackbar('Success', body['message']);
    // } else {
    //   Get.snackbar('Error', 'Failed to register');
    // }

    // isLoading(true);
    // await Future.delayed(const Duration(seconds: 2));
    // isLoading(false);
  }

  // Future login() async {
  //   isLoading(true);
  //   await Future.delayed(const Duration(seconds: 2));
  //   isLoading(false);
  // }
}
