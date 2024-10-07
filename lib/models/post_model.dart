import 'package:forum_app/models/user_model.dart';

class PostModel {
  int id;
  int userId;
  String content;
  DateTime createdAt;
  DateTime updatedAt;
  bool liked;
  User user;

  PostModel({
    required this.id,
    required this.userId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.liked,
    required this.user,
  });
}
