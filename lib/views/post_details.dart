import 'package:flutter/material.dart';
import 'package:forum_app/controllers/post_controller.dart';
import 'package:forum_app/models/post_model.dart';
import 'package:forum_app/views/widgets/input_widget.dart';
import 'package:forum_app/views/widgets/postdata_widget.dart';
import 'package:get/get.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({super.key, required this.post});

  final PostModel post;
  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  final TextEditingController _commentController = TextEditingController();
  final PostController _postController = Get.put(PostController());

  @override
  void initState() {
    // TODO: implement initState
    // _postController.getComments(widget.post.id!);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _postController.getComments(widget.post.id!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.user!.name!),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              PostData(post: widget.post),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 300,
                child: Obx(() {
                  return _postController.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: _postController.comments.value.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(_postController
                                  .comments.value[index].user!.name!),
                              subtitle: Text(
                                  _postController.comments.value[index].body!),
                            );
                          },
                        );
                }),
              ),
              InputWidget(
                  hintText: 'Write a comment',
                  controller: _commentController,
                  obscureText: false),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                onPressed: () {
                  // Add comment functionality
                },
                child: const Text('Comment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
