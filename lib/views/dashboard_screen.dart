import 'package:flutter/material.dart';
import 'package:musix_admin/widget/appbar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbar(),
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
                title: 'Playlist Manager',
                image: 'assets/music_manage.jpg',
                onTap: () {},
              ),
              DashboardCard(
                title: 'Post Manager',
                image: 'assets/report_manage.jpg',
                onTap: () {},
              ),
              DashboardCard(
                title: 'Comment Manager',
                image: 'assets/comment_manage.jpg',
                onTap: () {},
              ),
              DashboardCard(
                title: 'User Manager',
                image: 'assets/user_manage.jpg',
                onTap: () {},
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
