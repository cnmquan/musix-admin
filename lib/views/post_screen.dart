import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix_admin/actions/actions.dart';
import 'package:musix_admin/blocs/blocs.dart';
import 'package:musix_admin/models/models.dart';
import 'package:musix_admin/states/post_state.dart';
import 'package:musix_admin/utils/utils.dart';
import 'package:musix_admin/models/post.dart';

import '../blocs/report_post_bloc.dart';
import '../states/report_post_state.dart';
import '../utils/status.dart';
import '../widget/appbar.dart';
import '../widget/comment_data_table.dart';
import '../widget/custom_video_player.dart';
import '../widget/list_report_post_widget.dart';

class PostScreen extends StatefulWidget {
  final Post post;
  const PostScreen({
    super.key,
    required this.post,
  });

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen>
    with SingleTickerProviderStateMixin {
  late bool isBlocked;
  late TabController tabController;
  @override
  void initState() {
    isBlocked = widget.post.postStatus == "block" ? true : false;
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppbar(
          title: 'Post',
        ),
        body: SafeArea(
          child: Column(
            children: [
              BlocListener<PostsBloc, PostState>(
                listener: (context, state) {
                  if (state.status == Status.loading &&
                      state.key == "Modify post") {
                    buildShowDialog(context);
                  } else if (state.status == Status.success &&
                      state.key == "Modify post") {
                    Navigator.pop(context);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: !isBlocked
                              ? Colors.red
                              : Colors.white.withOpacity(.8)),
                      onPressed: !isBlocked
                          ? () {
                              context
                                  .read<PostsBloc>()
                                  .add(ChangingStatusPostEvent(widget.post.id));
                              setState(() {
                                isBlocked = !isBlocked;
                              });
                            }
                          : null,
                      child: const Text("BLOCK",
                          style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: isBlocked
                              ? Colors.green
                              : Colors.grey.withOpacity(.5)),
                      onPressed: isBlocked
                          ? () {
                              context
                                  .read<PostsBloc>()
                                  .add(ChangingStatusPostEvent(widget.post.id));
                              setState(() {
                                isBlocked = !isBlocked;
                              });
                            }
                          : null,
                      child: const Text("OPEN",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              Text(
                widget.post.content,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.post.thumbnailUrl,
                  width: 150,
                  height: 150,
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomVideoPlayer(
                dataUrl: widget.post.fileUrl,
              ),
              TabBar(
                controller: tabController,
                tabs: const [
                  Tab(
                    text: "Report",
                  ),
                  Tab(
                    text: "Comment",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    BlocBuilder<ReportPostBloc, ReportPostState>(
                      builder: (context, state) {
                        return ListReportPostWidget(
                          reportPosts: state.reportPosts,
                        );
                      },
                    ),
                    const CommentDataTable()
                  ],
                ),
              )
              // DefaultTabController(
              //   length: 2,
              //   child: TabBarView(
              //     children: [

              //     ],
              //   ),
              // )
            ],
          ),
        ));
  }
}
