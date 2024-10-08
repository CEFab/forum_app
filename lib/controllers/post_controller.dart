import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forum_app/constants/constants.dart';
import 'package:forum_app/models/post_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class PostController extends GetxController {
  Rx<List<PostModel>> posts = Rx<List<PostModel>>([]);
  // final posts = [].obs;
  final isLoading = false.obs;
  final box = GetStorage();
  // final token = GetStorage().read('token');

  @override
  void onInit() {
    getAllPosts();
    super.onInit();
  }

  Future getAllPosts() async {
    try {
      isLoading.value = true;
      var response = await http.get(
        Uri.parse('${url}feeds'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
          // 'Bearer token': box.read('token'),
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        // posts.value = json.decode(response.body)['data'];
        // print(json.decode(response.body));
        for (var feed in json.decode(response.body)['feeds']) {
          posts.value.add(PostModel.fromJson(feed));
        }
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
}
