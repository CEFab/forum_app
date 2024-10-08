import 'package:flutter/material.dart';
import 'package:forum_app/controllers/post_controller.dart';
import 'package:forum_app/views/widgets/postdata_widget.dart';
import 'package:forum_app/views/widgets/postfield_widget.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PostController _postController = Get.put(PostController());
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final box = GetStorage();
    // var token = box.read('token');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forum App'),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostField(
                hintText: 'What\'s on your mind?',
                controller: _textController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                onPressed: () async {
                  await _postController.createPost(
                      content: _textController.text.trim());
                  _textController.clear();
                  _postController.getAllPosts();
                },
                child: Obx(() {
                  return _postController.isLoading.value
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text('Post');
                  // return const Text('Post');
                }),
              ),
              const SizedBox(height: 20),
              const Text('Posts:'),
              const SizedBox(height: 20),
              Obx(() {
                return _postController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _postController.posts.value.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              PostData(
                                  post: _postController.posts.value[index]),
                              const SizedBox(
                                  height: 10), // Add space between items
                            ],
                          );
                        },
                      );
              })
            ],
          ),
        ),
      ),
    );
  }
}
