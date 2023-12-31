import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix_admin/actions/actions.dart';
import 'package:musix_admin/actions/report_post_event.dart';
import 'package:musix_admin/blocs/blocs.dart';
import 'package:musix_admin/blocs/report_post_bloc.dart';
import 'package:musix_admin/views/post_manager_screen.dart';
import 'package:musix_admin/views/report_post_screen.dart';
import 'package:musix_admin/views/user_manager_screen.dart';
import 'package:musix_admin/widget/appbar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppbar(
          title: 'Dashboard',
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Wrap(
            spacing: 24,
            runSpacing: 24,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              DashboardCard(
                title: 'Music Manager',
                image: 'assets/music_manage.jpg',
                onTap: () {},
              ),
              DashboardCard(
                title: 'Artist Manager',
                image: 'assets/music_manage.jpg',
                onTap: () {},
              ),
              DashboardCard(
                title: 'Report Post Manager',
                image: 'assets/music_manage.jpg',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ReportPostScreen()));
                },
              ),
              DashboardCard(
                title: 'Post Manager',
                image: 'assets/report_manage.jpg',
                onTap: () {
                  context.read<PostsBloc>().add(const GetPostsEvent());
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PostManagerScreen()));
                },
              ),
              DashboardCard(
                title: 'Comment Manager',
                image: 'assets/comment_manage.jpg',
                onTap: () {},
              ),
              DashboardCard(
                title: 'User Manager',
                image: 'assets/user_manage.jpg',
                onTap: () {
                  context.read<ProfilesBloc>().add(const LoadProfilesEvent());
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const UserManagerScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback? onTap;
  const DashboardCard({
    super.key,
    required this.title,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: const BorderSide(
          color: Colors.white54,
          width: 2,
        ),
        padding: const EdgeInsets.all(12),
      ),
      onPressed: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 12,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              image,
              width: 144,
              height: 144,
              fit: BoxFit.fitHeight,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
