import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix_admin/blocs/blocs.dart';
import 'package:musix_admin/states/states.dart';
import 'package:musix_admin/views/views.dart';
import 'package:musix_admin/widget/custom_video_player.dart';

import '../widget/appbar.dart';

class PostManagerScreen extends StatelessWidget {
  const PostManagerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Post Manager',
      ),
      body: SafeArea(
          child: Column(
        children: [
          BlocBuilder<PostsBloc, PostState>(builder: (context, state) {
            return Expanded(
              child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 1000,
                columns: const [
                  DataColumn2(
                    label: Text('No. '),
                  ),
                  DataColumn2(
                    label: Text('Post Id'),
                  ),
                  DataColumn2(
                    label: Text('Content'),
                  ),
                  DataColumn2(
                    label: Text('Owner Id'),
                  ),
                  DataColumn2(
                    label: Text('Owner Name'),
                  ),
                  DataColumn2(
                    label: Text('File Name'),
                  ),
                  DataColumn2(
                    label: Text('Thumbnail'),
                  ),
                  DataColumn2(
                    label: Text('File'),
                  ),
                  DataColumn2(
                    label: Text('LikeBy'),
                  ),
                  DataColumn2(
                    label: Text('Comments'),
                  ),
                  DataColumn2(
                    label: SizedBox.shrink(),
                    fixedWidth: 20,
                  ),
                ],
                rows: List<DataRow>.generate(state.posts.length, (index) {
                  final post = state.posts[index];
                  return DataRow(
                    cells: [
                      DataCell(
                        Text('$index'),
                      ),
                      DataCell(
                        Text(post.id),
                      ),
                      DataCell(
                        Text(post.content),
                      ),
                      DataCell(
                        Text(post.ownerId),
                      ),
                      DataCell(
                        Text(post.ownerName),
                      ),
                      DataCell(
                        Text(post.fileName),
                      ),
                      DataCell(ElevatedButton(
                        child: const Text("Preview"),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      post.thumbnailUrl,
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                );
                              });
                        },
                      )),
                      DataCell(ElevatedButton(
                        child: const Text("Preview"),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: CustomVideoPlayer(
                                    dataUrl: post.fileUrl,
                                  ),
                                );
                              });
                        },
                      )),
                      DataCell(
                        Text('${post.likeBy.length}'),
                      ),
                      DataCell(
                        Text('${post.comments.length}'),
                      ),
                      DataCell(Icon(Icons.book), onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => PostScreen(post: post)));
                      })
                    ],
                  );
                }),
              ),
            );
          })
        ],
      )),
    );
  }
}
