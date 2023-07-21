import 'package:flutter/material.dart';
import 'package:musix_admin/models/models.dart';

import '../widget/appbar.dart';
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
        ],
      )),
    );
  }
}
