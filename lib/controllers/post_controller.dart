import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forum_app/constants/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PostController extends GetxController {
  final posts = [].obs;
  final isLoading = false.obs;
  final box = GetStorage();
  // final token = GetStorage().read('token');

  @override
  void onInit() {
    super.onInit();
    getAllPosts();
  }

  get http => null;

  Future getAllPosts() async {
    try {
      isLoading.value = true;
      var response = await http.get(
        Uri.parse('${url}posts'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );

      if (response.statusCode == 200) {
        // isLoading.value = false;
        // posts.value = json.decode(response.body)['data'];
        print(json.decode(response.body));
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print(json.decode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  void addPost(Map<String, dynamic> post) {
    posts.add(post);
  }

  void removePost(int index) {
    posts.removeAt(index);
  }
}
