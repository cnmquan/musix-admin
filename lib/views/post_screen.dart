import 'package:flutter/material.dart';
import 'package:musix_admin/models/post.dart';

import '../widget/appbar.dart';
import '../widget/comment_data_table.dart';
import '../widget/custom_video_player.dart';

class PostScreen extends StatelessWidget {
  final Post post;
  const PostScreen({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Post',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(post.content),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  post.thumbnailUrl,
                  width: 200,
                  height: 200,
                  fit: BoxFit.fitWidth,
                ),
              ),
              CustomVideoPlayer(
                dataUrl: post.fileUrl,
              ),
              SizedBox(
                height: 400,
                child: Builder(builder: (context) {
                  return const CommentDataTable();
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
