import 'package:flutter/material.dart';
import 'package:forum_app/controllers/post_controller.dart';
import 'package:forum_app/models/post_model.dart';
import 'package:forum_app/views/post_details.dart';
import 'package:get/get.dart';

class PostData extends StatefulWidget {
  const PostData({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  State<PostData> createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
  final PostController _postController = Get.put(PostController());
  Color likedPost = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      // height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.post.user!.name!),
          Text(
            widget.post.user!.email!,
            style: TextStyle(fontSize: 10),
          ),
          const SizedBox(height: 10),
          Text(
            widget.post.content!,
            style: TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  await _postController.likeAndDislike(widget.post.id!);
                  _postController.getAllPosts();
                },
                icon: Icon(Icons.thumb_up,
                    color: widget.post.liked! ? Colors.blue : Colors.black),
              ),
              IconButton(
                onPressed: () {
                  Get.to(() => PostDetails(
                        post: widget.post,
                      ));
                },
                icon: Icon(Icons.message),
              ),
              // Delete functionality
              IconButton(
                onPressed: () async {
                  await _postController.deletePost(widget.post.id!);
                  _postController.getAllPosts();
                },
                icon: Icon(Icons.delete),
              ),
            ],
          )
        ],
      ),
    );
  }
}
