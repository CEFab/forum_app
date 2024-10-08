import 'package:flutter/material.dart';
import 'package:forum_app/models/post_model.dart';
import 'package:forum_app/views/post_details.dart';
import 'package:get/get.dart';

class PostData extends StatelessWidget {
  const PostData({
    super.key,
    required this.post,
  });

  final PostModel post;

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
          Text(post.user!.name!),
          Text(
            post.user!.email!,
            style: TextStyle(fontSize: 10),
          ),
          const SizedBox(height: 10),
          Text(
            post.content!,
            style: TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.thumb_up),
              ),
              IconButton(
                onPressed: () {
                  Get.to(() => PostDetails(
                        post: post,
                      ));
                },
                icon: Icon(Icons.message),
              )
            ],
          )
        ],
      ),
    );
  }
}
